require 'sinatra'
require 'redis'

REDIS = Redis.new(host: 'redis_1', port: 6379, password: nil)
set :port, 4567
set :bind, '0.0.0.0'

get '/' do
  erb :index
end

post '/' do
  if params[:url] =~ URI::regexp
    @token = shortlink_token
    REDIS.set("links:#{@token}", params[:url])
    erb :shortened
  else
    @error = "Please enter a valid URL."
    erb :index
  end
end

get '/:token/?' do
  url = REDIS.get("links:#{params[:token]}")
  redirect url if url
  erb :expired
end

helpers do
  def shortlink_token
    (Time.now.to_i + rand(36**8)).to_s(36)
  end
end
