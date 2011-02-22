require 'rubygems'
#require 'bundler'
#Bundler.require

log = File.new("log/sinatra.log", "a")
STDOUT.reopen(log)
STDERR.reopen(log)

require 'presentor'

run Presentor::Application