# ENiGMA BBS

Docker container that runs [ENiGMA½ BBS Software](https://github.com/NuSkooler/enigma-bbs). All required packages for 
ENiGMA½ to run successfully are included, and pm2-docker is used to manage the Node.js process.

## Quick Start

This container image is available from the Docker Hub.

Assuming that you have Docker installed, run the following command:

````bash
docker run -d \
  -p 8888:8888 \
  davestephens\enigma-bbs
````

As no config has been supplied, the container will use a basic one so that it starts successfully. ENiGMA½ listens via
telnet on port 8888. Connect and try it out!

## A Proper Setup

So you've decided ENiGMA½ (and Docker) is for you, and you want a "proper" setup. There are a few things you need to do:

1. Create a directory on your Docker host machine to store ENiGMA½ data, e.g. ~/my_sweet_bbs. Within that, create directories
for the mountable volumes - config, db, filebase, logs, mail, misc and mods.

    *NB: Data within the **misc** and **mods** volumes will be **copied** into the same directory within /enigma-bbs 
    when the container starts. The other directories will be mounted and used directly. This is so that you can add additional 
    files to ENiGMA½'s mods and misc directories, such as your own custom ANSI theme, ENiGMA½ mods, public and private keys etc.*

2. Create a config.hjson file within the config directory you created. See the ENiGMA½ docs for available options.

3. Copy any customisations such as themes and mods, to the mods directory.

    You should end up with a structure like the following:
    
    ````text
    ├── config
    │   └── config.hjson
    ├── db
    ├── filebase
    ├── logs
    ├── mail
    ├── misc
    └── mods
        ├── art
        ├── awesome_mod
        └── themes
            └── sick_theme
    ````

4. Start the container:
    ````bash
    docker run -d \
        -p 8888:8888 \
        -v ~/my_sweet_bbs/config:/config \
        -v ~/my_sweet_bbs/db:/enigma-bbs/db \
        -v ~/my_sweet_bbs/logs:/enigma-bbs/logs \
        -v ~/my_sweet_bbs/mail:/enigma-bbs/mail \
        -v ~/my_sweet_bbs/filebase:/enigma-bbs/filebase \
        -v ~/my_sweet_bbs/mods:/mods \
        -v ~/my_sweet_bbs/misc:/misc \
        davestephens\enigma-bbs
    ````

### Volumes

The following volumes are mountable:

| Volume                  | Usage                                            |
|:------------------------|:-------------------------------------------------|
| /config                 | Save your config in here as config.hjson         |
| /misc                   | Misc stuff, certs etc                            |
| /mods                   | ENiGMA mods and themes                           |
| /enigma-bbs/db          | ENiGMA databases                                 |
| /enigma-bbs/filebase    | Filebase                                         |
| /enigma-bbs/logs        | Logs                                             |
| /enigma-bbs/mail        | FTN mail (for use with an external mailer)       |

## License 

This project is licensed under the [BSD 2-Clause License](LICENSE).
