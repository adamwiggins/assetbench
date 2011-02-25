require 'sinatra'

require 'sinatra/cache_assets'
use Sinatra::CacheAssets

%w(1k 16k 64k).each do |size|
  get "/dyno/#{size}" do
    File.read("public/varnish/#{size}")
  end
end
