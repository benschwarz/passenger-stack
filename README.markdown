# Passenger stack, zero to hero in under five minutes
Scripts for [Sprinkle](http://github.com/crafterm/sprinkle/ "Sprinkle"), the provisioning tool

## How to get your sprinkle on:

* Get a brand spanking new slice / host (Ubuntu please)
* Create yourself a user, add yourself to the /etc/sudoers file
* Set your slices url / ip address in deploy.rb (config/deploy.rb.example provided)
* Set username in config/deploy.rb if it isn't the same as your local machine (config/deploy.rb.example provided)

From your local system (from the passenger-stack directory), run:

    sprinkle -c -s config/install.rb

After you've waited for everything to run, you should have a provisioned slice.
Go forth and install your custom configurations, add vhosts and other VPS paraphernalia.

Other things you should probably consider:

* Close everything except for port 80 and 22
* Disallow password logins and use a passphrased RSA key

### My app isn't running

Read [these tips](http://github.com/benschwarz/passenger-stack/wikis/my-app-isnt-running) to get you humming

### Wait, what does all this install?

* Apache (Apt)
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
* An Ubuntu based VPS (known to not work on Debian Etch†)

## Thanks

* Marcus Crafter and other Sprinkle contributors
* Slicehost, for giving a free slice for testing passenger stack
* Nathan de Vries for Postgres support

## Disclaimer

Don't run this on a system that has already been deemed "in production", its not malicious, but theres a fair chance
that you'll ass something up monumentally. You have been warned. 

### Footnotes

† This issue lies between differences in apt between debian and ubuntu, my feedback has been forwarded and discussed with Marcus, the author of sprinkle. I believe he is looking into it.
