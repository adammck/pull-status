#!/usr/bin/env ruby
# vim: et ts=2 sw=2

require "sinatra"
require "octokit"
require "redis"
require "json"

# Init

$redis = Redis.new
VERSION = %x{git show-ref --hash=7 --head HEAD}.strip
NAMESPACE = "pullstatus:#{VERSION}"
TTL = 60 * 5



# Routes

get "/:user/:repo/pull/:num" do
  pull_request = PullRequest.new params
  send_file "images/#{pull_request.status}.png",
    :last_modified=>pull_request.updated_at
end


# Models

class PullRequest
  def initialize params
    @user = params[:user]
    @repo = params[:repo]
    @num = params[:num]
  end

  def status
    if pull_request["merged_at"]
      "merged"

    elsif pull_request["closed_at"]
      "rejected"

    else
      "open"
    end
  end

  def method_missing meth, *args, &block
    pull_request[meth.to_s]
  end

  def pull_request
    @pr ||= get!
  end

  private

  def key
    "#{NAMESPACE}:#{repo}/#{@num}"
  end

  def repo
    "#{@user}/#{@repo}"
  end

  def get!
    json = $redis.get(key)

    if json.nil?
      json = fetch!.to_json
      $redis.setex key, TTL, json
    end

    JSON.parse(json)
  end

  def fetch!
    puts "Fetching: #{key} PUTS"
    Octokit.pull(repo, @num)
  end
end
