# Webistrano

[Webistrano][1] is a frontend to manage deployments through [capistrano][0]. This port
aims to provide a simple and integrated installation on FreeBSD.

[0]: http://www.capify.org/
[1]: http://labs.peritor.com/webistrano

# README

## Install HowTo

 * clone repository
 * `cd webistrano-freebsd/`
 * `make && make install`

## TODO

 * create RC-script to start webistrano when the server starts
 * split port into `%%PREFIX%%` and `%%WWWDIR%%`
 * maybe replace included plugins with ports