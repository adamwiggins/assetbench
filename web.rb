require 'sinatra'

class VarnishApp < Sinatra::Base
  require 'sinatra/cache_assets'
  use Sinatra::CacheAssets

  set :public, File.dirname(__FILE__) + '/public'
end

class DynoApp < Sinatra::Base
  %w(1k 16k 64k).each do |size|
    get "/dyno/#{size}" do
      File.read("public/varnish/#{size}")
    end
  end
end

class CachedApp < Sinatra::Base
  require './no_varnish'
  use NoVarnish

  require 'dalli'
  CACHE = Dalli::Client.new

  require 'rack/cache'
  use Rack::Cache, :metastore => CACHE, :entitystore => CACHE, :verbose => true

  %w(1k 16k 64k).each do |size|
    get "/cached/#{size}" do
      cache_control :public, :max_age => 12*60*60
      File.read("public/varnish/#{size}")
    end
  end
end
