#!/usr/bin/env ruby
# vim: et ts=2 sw=2

require "sinatra"
require "octokit"
require "redis"


# Init

redis = Redis.new
NS = "pullstate"
TTL = 60 * 5


# Routes

get "/:user/:repo/pull/:number" do
  k = key params
  fn = redis.get k

  unless fn
    fn = state params
    redis.setex k, TTL, fn
  end

  send_file "images/#{fn}.png"
end


# Helpers

def key p
  "#{NS}:#{p[:user]}/#{p[:repo]}/#{p[:number]}"
end

def pull_request! p
  repo = "#{p[:user]}/#{p[:repo]}"
  Octokit.pull repo, p[:number]
end

def state p
  pull = pull_request! p
  if pull.merged_at
    "merged"

  elsif pull.closed_at
    "rejected"

  else
    "open"
  end
end