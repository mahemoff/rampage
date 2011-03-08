ENV['GEM_PATH'] = ENV['USER']+'/.gems:/usr/lib/ruby/gems/1.8'
require 'rubygems'
require 'sinatra'
require 'mustache'
require 'json'

require 'rampage.rb'
run Sinatra::Application

FileUtils.mkdir_p 'log' unless File.exists?('log')
log = File.new("log/sinatra.log", "a")
$stdout.reopen(log)
$stderr.reopen(log)
