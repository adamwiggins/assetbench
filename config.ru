require './web'
run Rack::Cascade.new [ VarnishApp, DynoApp, CachedApp ]
