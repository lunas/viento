# Viento App


## Deploy


### Base

This is a not exhaustive list:

* `git clone git@github.com:lunas/viento.git`
* `brew install mysql`
* adapt config/database.yml
* `brew install redis`
  * To have it started at login: `ln -sfv /usr/local/opt/redis/*.plist ~/Library/LaunchAgents`
* `brew install nginx`
* `bundle install`

To create the db, tables, and initial users: `rake db:setup`

### Nginx and Unicorn

#### Nginx

These steps work for OSX Maverick.

```
brew install nginx
```

Adapt the path to the root in the application's nginx configuration file `config/nginx.conf`:
```
  root /PATH/TO/VIENTO-APPLICATION-ROOT/public;
```

Then create sites-enabled in /usr/local/etc/nginx: 

```
mkdir /usr/local/etc/nginx/sites-enabled
```

Edit /usr/local/etc/nginx/nginx.conf so it include sites-enabled:  
In the section `htpp` add the line:

```
  include /usr/local/etc/nginx/sites-enabled/*;
```

Then, in `/etc/local/etc/nginx/sites-enabled/`, create a simlink to our nginx.conf file:

```
ln -s /PATH/TO/VIENTO-APPLICATION-ROOT/config/nginx.conf  /usr/local/etc/nginx/sites-enabled/viento
```

To restart nginx: 

```
sudo nginx -s reload
```

Or stop nginx before changing nginx.conf (`sudo nginx -s stop`), then start it with `sudo nginx`.

#### Unicorn

Find [detailed information here](https://github.com/blog/517-unicorn).

Create the file `tmp/pids/` in your application directory.

In the application root, run 

```
bundle install --binstubs
```

...to create executables for many gems.

Adapt `config/unicorn_init.sh`:   
The APP_ROOT should point to the applications' root.
 
Make it executable: `chmod +x config/unicorn_init.sh`




### Start

Run the start script. It

* starts redis: `redis-server /usr/local/etc/redis.conf`
* starts sidekiq: `bundle exec sidekiq`
* starts nginx 
* starts unicorn (via config/unicorn_init.sh)
* deletes public/index.html (might have been cached from old session)

### Cron/Whenever

To setup regular backup:

* set the correct log path in config/schedule.rb (must be an absolute path!)
* cd to the app directory and run `whenever --update-crontab viento`
