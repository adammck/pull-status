#!/usr/bin/env ruby
# vim: et ts=2 sw=2

require "sinatra"
require "octokit"

get "/:user/:repo/pull/:number" do
  repo = "#{params[:user]}/#{params[:repo]}"
  pull = Octokit.pull repo, params[:number]

  filename = if pull.merged_at
    "merged"

  elsif pull.closed_at
    "rejected"

  else
    "open"
  end

  send_file "images/#{filename}.png"
end
