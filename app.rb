require 'sinatra'
require 'sinatra/cross_origin'
require 'json'

require_relative 'config/redis'

register Sinatra::CrossOrigin

configure do
  enable :cross_origin
end

COOKIES_KEY = 'cookie:domains'

get '/cookies/:domain' do
  content_type :json
  { cookies: $redis.hget(COOKIES_KEY, params[:domain]) }.to_json
end

post '/cookies/:domain' do
  status 201
  $redis.hset(COOKIES_KEY, params[:domain], params[:cookies])
end

get '/test-cookies/:domain' do
  status 201
  $redis.hset(COOKIES_KEY, params[:domain], params[:cookies])
end
