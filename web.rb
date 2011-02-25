require 'sinatra'

require 'sinatra/cache_assets'
use Sinatra::CacheAssets

get '/' do
  "hello"
end
