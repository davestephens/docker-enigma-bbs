ENiGMA BBS
==========
Docker container that runs ENiGMA BBS. All required packages for ENiGMA to run successfully, 
and pm2 is used to manage the Node.js process.

Quick Start
-----------
The container is available from the Docker Hub and this is the simplest way to get it.

Assuming that you have Docker installed, run the following command:

````bash
docker run -d \
  -p 8888:8888 \
  davestephens\enigma-bbs
````

As no config has been supplied, the container will use a basic one so that it starts successfully.

A Proper Setup
--------------
You should mount the following volumes so that ENiGMA data is stored outside of the 
container:

| Volume                  | Usage                                            |
|:------------------------|:-------------------------------------------------|
| /enigma-bbs/config      | Save your config in here as enigma.hjson         |
| /enigma-bbs/db          | ENiGMA databases                                 |
| /enigma-bbs/logs        | Logs                                             |
| /enigma-bbs/mail        | FTN mail                                         |
| /enigma-bbs/filebase    | Filebase                                         |

Any data presented to the container in these directories will be copied into the 
relevant directory within ENiGMA:

| Volume                  | Usage                                            |
|:------------------------|:-------------------------------------------------|
| /art                    | Custom art ANSI files                            |
| /mods                   | ENiGMA mods and themes                           |
| /misc                   | Misc stuff, certs etc                            |

Example container startup command:

````bash
docker run -d \
    -p 8888:8888 \
    -v ~/enigma-bbs/config:/enigma-bbs/config
    -v ~/enigma-bbs/db:/enigma-bbs/db
    -v ~/enigma-bbs/logs:/enigma-bbs/logs
    -v ~/enigma-bbs/mail:/enigma-bbs/mail
    -v ~/enigma-bbs/filebase:/enigma-bbs/filebase
    -v ~/enigma-bbs/art:/art
    -v ~/enigma-bbs/mods:/mods
    -v ~/enigma-bbs/misc:/misc
    davestephens\enigma-bbs
````


