	 ____                                       _    _      
	/ ___| _ __   __ _  ___ ___  ___ ___   ___ | | _(_) ___ 
	\___ \| '_ \ / _` |/ __/ _ \/ __/ _ \ / _ \| |/ / |/ _ \
	 ___) | |_) | (_| | (_|  __/ (_| (_) | (_) |   <| |  __/
	|____/| .__/ \__,_|\___\___|\___\___/ \___/|_|\_\_|\___|
	      |_|    – haskell gopher server

## What is Gopher?

> The Gopher protocol /ˈɡoʊfər/ is a TCP/IP application layer protocol designed for distributing, searching, and retrieving documents over the Internet. The Gopher protocol was strongly oriented towards a menu-document design and presented an alternative to the World Wide Web in its early stages, but ultimately HTTP became the dominant protocol. The Gopher ecosystem is often regarded as the effective predecessor of the World Wide Web.

– [WP](https://en.wikipedia.org/wiki/Gopher_(protocol))

## What is Spacecookie?

Spacecookie is a gopher server and…

* is RFC1436-compliant
* supports info-line in menus (compatible protocol extension)
* supports gophermaps (see below)
* includes a library for custom gopher applications

## Configuration

In order to run your new gopher server, you got to configure it first. The example configuration file is `./etc/spacecookie.json`.

Let's have a quick look at the options:

option     | meaning                                                 
-----------|--------------------------------------------------------------------------------------------------------
`hostname` | The hostname your spacecookie will be reachable through.
`user`     | The user that just run spacecookie. It is used to drop root priveleges after binding the server socket.
`port`     | The port spacecookie should listen on. The well-known port for gopher is 70.
`root`     | The directory which the files to serve via gopher are located in.

## Running

After you've created your config file just start spacecookie like this:

	spacecookie /path/to/spacecookie.json

Of course it is more convenient to run it as a system wide demon. For that reason a systemd `spacecookie.service` is provided. You can use it like this:

	systemctl enable spacecookie.service
	systemctl start  spacecookie.service

Please note that you have to move the necessary file in place manually at the moment.

## Adding Content

Spacecookie acts as a simple file server, only excluding files that start with a dot.
It generates gopher menus automatically; however you can use custom ones by adding a gophermap file.

Spacecookie checks for `.gophermap` in every directory it serves and, if present, presents that menu to the user.

Such a file looks like this:

	You can just start writing text that
	will be displayed by the gopher client
	without a link to a file. Empty lines are
	also possible.

	1Menu Entry for a directory full of funny stuff	/funny
	iFunny Image	/funy.jpg
	gcat gif	/cat.gif
	0about me	/about.txt
	1Floodgap's gopher server	/	gopher.floodgap.com	70

So what does that all mean? These are the rules for a gophermap file:

* comment lines (called info lines in spacecookie's code) are just lines of text. They must not contain a tab! They will be displayed as lines of text by the gopher client.
* menu entries for files or directories start with a single char which specifies the file type, followed by the text for that file without a space or tab between them! Then the path is added after a tab.
* "Links" to other servers are like file/directory menu entries but the server's hostname and its port must be added (tab-separated).

The file type characters are defined in [RFC1436](https://tools.ietf.org/html/rfc1436#page-10). Detailed documentation on the gophermap format [can be found here](./docs/gophermap-pygopherd.txt).
