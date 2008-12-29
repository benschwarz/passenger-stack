# Passenger stack, zero to hero in under five minutes
Scripts for [Sprinkle](http://github.com/crafterm/sprinkle/ "Sprinkle"), the provisioning tool

## How to get your sprinkle on:

* Get a brand spanking new slice (ubuntu please)
* Create yourself a user, add yourself to the sudoers file
* Apt-get update
* Set your slices url / ip address in deploy.rb (deploy.rb.example provided)

From your local system (from the passenger-stack/config directory), run:

    sprinkle -c -s install.rb

After you've waited for everything to run, you should have a provisioned slice.
Go forth and install your custom configurations, add vhosts and other VPS paraphernalia.

Other things you should probably consider:

* Close everything except for port 80 and 22
* Disallow password logins and use a passphrased RSA key

### Wait, what does it install?

* Apache (Apt)
* Ruby enterprise (Source) [includes rubygems]
* Passenger (Rubygem)
* Libmemcached (Source)
* MySQL (Apt)
* Git (Apt)

## Requirements
* Ruby
* Capistrano
* Sprinkle (github.com/crafterm/sprinkle)
* An Ubuntu based VPS (known to not work on Debian Etch, this is a sprinkle apt issue and has been forwarded to crafterm)

## Thanks

Marcus Crafter and other Sprinkle contributors

## Disclaimer

Don't run this on a system that has already been deemed "in production", its not malicious, but theres a fair chance
that you'll ass something up monumentally. You have been warned. 