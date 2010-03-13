# Passenger stack, zero to hero in under five minutes
Scripts for [Sprinkle](http://github.com/crafterm/sprinkle/ "Sprinkle"), the provisioning tool

[Watch the demo screen cast](http://www.vimeo.com/2888665) of passenger-stack.

## How to get your sprinkle on:

* Get a brand spanking new slice / host (Debian or Ubuntu please, other apt-based sytems might work too)
* Install sudo if you are on Debian
* Create yourself a user (use `adduser`), add yourself to the /etc/sudoers file
* Set your slices url / ip address in deploy.rb (config/deploy.rb.example provided)
* Set username in config/deploy.rb if it isn't the same as your local machine (config/deploy.rb.example provided)

From your local system (from the passenger-stack directory), run:

    sprinkle -c -s config/install.rb

After you've waited for everything to run, you should have a provisioned slice.
Go forth and install your custom configurations, add vhosts and other VPS paraphernalia.

### My app isn't running!?

No superfluous configuation is included, these scripts focus purely on slice installation. 
Having said that passenger is configured to work with apache, your application should pretty much be a 'drop in' install.

Read [these tips](http://github.com/benschwarz/passenger-stack/wikis/my-app-isnt-running) to get you humming

Other things you should probably consider:

* Close everything except for port 80 and 22
* Disallow password logins and use a passphrased RSA key

#### "Connection reset by peer"

You can work around this issue by tweaking `/etc/ssh/sshd_config` to include the following on the server:
  
    ClientAliveInterval 60
    ClientAliveCountMax 15

### Wait, what does all this install?

* Apache (Apt)
  * Scripts and stylesheets are compressed using mod_deflate
  * ETags are applied to static assets
  * Expires headers are applied to static assets
  
or 

* Nginx (Source)  
  
* Ruby Enterprise (Source) [includes rubygems]
* Passenger (Rubygem)
* Memcached (Apt)
* Libmemcached (Source)
* MySQL (Apt) or PostgreSQL (Apt)
* MySQL or PostgreSQL ruby database drivers (Rubygem)
* Git (Apt)

## Requirements
* Ruby
* Capistrano
* Sprinkle (github.com/crafterm/sprinkle)
* An Ubuntu or Debian based VPS

If you're interested in using Fedora or RedHat then maybe you should checkout one of these:

* http://github.com/nwp/passenger-stack
* http://github.com/l15n/yummy-sprinkles
* http://github.com/kjwierenga/passenger-stack

## Thanks

* [Marcus Crafter](http://github.com/crafterm) and other Sprinkle contributors
* [Slicehost](http://slicehost.com), for giving a free slice for testing passenger stack
* [Nathan de Vries](http://github.com/atnan) for Postgres support
* [Anthony Kolber](http://aestheticallyloyal.com) for the github pages design
* [Stephen Eley](http://github.com/SFEley) for some sanity checks on git dependencies
* [James Chen](http://github.com/ashchan) for finishing the nginx-module support that I never got to. Awesome!

## Disclaimer

Don't run this on a system that has already been deemed "in production", its not malicious, but there is a fair chance
that you'll ass something up monumentally. You have been warned. 