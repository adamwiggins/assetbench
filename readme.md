Setup
-----

    $ brew install memcached
    $ bundle install
    $ gem install foreman

Run local
---------

    $ memcached
    $ foreman start
    $ curl -I http://localhost:5000/dyno/1k
    $ curl -I http://localhost:5000/varnish/1k
    $ curl -I http://localhost:5000/cached/1k

Deploy
------

    $ heroku create --stack <yourfavoritestack>
    $ git push heroku master
    $ heroku addons:add memcache
    $ curl -I http://yourapp.heroku.com/dyno/1k
    $ curl -I http://yourapp.heroku.com/varnish/1k
    $ curl -I http://yourapp.heroku.com/cached/1k

