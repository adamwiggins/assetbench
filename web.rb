require 'sinatra'

require 'sinatra/cache_assets'
use Sinatra::CacheAssets

require 'dalli'
CACHE = Dalli::Client.new

require 'rack/cache'
use Rack::Cache, :metastore => CACHE, :entitystore => CACHE

%w(1k 16k 64k).each do |size|
  get "/dyno/#{size}" do
    File.read("public/varnish/#{size}")
  end
end

%w(1k 16k 64k).each do |size|
  get "/cached/#{size}" do
		response['Cache-Control'] = "public, max-age=#{12*60*60}"
    File.read("public/varnish/#{size}")
  end
end
