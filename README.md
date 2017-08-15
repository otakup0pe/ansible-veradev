# vera dev

Despite the fact the [smart home](http://softra.in) being a myth, one of my hobbies is home automation. This entails a lot of hacking on a [Vera3](http://getvera.com/controllers/vera3/) which runs [MiOS](http://www.mios.com/).

This is an Ansible role I use to copy a few scripts onto my development environments.

# installation

Include this role into an Ansible run? You probably want to change the [defaults](https://github.com/otakup0pe/ansible-veradev/blob/master/defaults/main.yml).

# vera-reload

This script will run some quick syntax checks on any xml, json, or lua files in the specified directory before uploading them to your vera. You will need passwordless ssh and your vera will have to resolve to `vera`. If you do not specify a directory it uses your cwd.

# vera-log

Will tail the LUA engine log on your vera. You will need passwordless ssh.

# author

These bytes were manifested by [Jonathan Freedman](http://jonathanfreedman.bio/) who still believes the smart home is a myth.
