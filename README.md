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

Edit /usr/local/etc/nginx/nginx.conf so it includes sites-enabled:  
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

To make sure nginx can be started as non-root, create the log file and change its
access rights so it is writable for everybody:

```
cd ~/Sites/viento/
touch log/nginx.log
chmod 666 log/nginx.log
```

To start nginx then right away:
```
nginx
```

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

Run the start script ```script/start.command``` (double click). It...

* stops existing nginx, redis, unicorn, and sidekiq processes, then
* starts redis: `redis-server /usr/local/etc/redis.conf`
* starts sidekiq: `bundle exec sidekiq`
* starts nginx 
* starts unicorn (via config/unicorn_init.sh)

To stop all services, run ```script/stop.command```.

### Cron/Whenever

To setup regular backup:

* set the correct log path in config/schedule.rb (must be an absolute path!)
* cd to the app directory and run `whenever --update-crontab viento`

## Feedback email

To enable sending feedback emails, create the file ```.env``` in the root directory and 
put the correct username and password for the Gmail account otniev.gmail.com into it:

```
GMAIL_USERNAME=otniev    
GMAIL_PASSWORD=the_password
```