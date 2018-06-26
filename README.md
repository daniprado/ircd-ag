# IRCd-ag
> ZNC + UnrealIRCd + Bitlbee servers configured together and running on the same container.

This docker container starts a [ZNC IRC bouncer](https://wiki.znc.in/ZNC) server exposing it. It has its [webadmin module](https://wiki.znc.in/Webadmin) on the same port letting you configure the server at will.\
The container also starts a [UnrealIRCd server daemon](https://www.unrealircd.org/) and a [Bitlbee server](https://www.bitlbee.org/main.php/news.r.html) (IM to IRC connector service).\
You can configure [ZNC's networks](https://wiki.znc.in/Configuration#Network) to use both of them...\
Bitlbee server has also plugins to connect to Skype, Mastodon, Telegram and Steam networks.

## Usage
* Clone this repository.
* Build the image.
```
docker build -t ircd-ag .

or

docker-compose create
```
* Run the service for the first time.
```
docker run \
  --name=ircd \
  -p 7667:7667 \
  -v /docker/volumes/ircd/unrealircd/conf:/home/unrealircd/unrealircd/conf \
  -v /docker/volumes/ircd/unrealircd/logs:/home/unrealircd/unrealircd/logs \
  -v /docker/volumes/ircd/bitlbee/etc:/etc/bitlbee \
  -v /docker/volumes/ircd/bitlbee/lib:/var/lib/bitlbee \
  -v /docker/volumes/ircd/znc/lib:/var/lib/znc \
ircd-ag

or

docker-compose up ircd
```
> Note you need to create `/docker/volumes` path in advance. Otherwise change docker-compose.yml or `docker run` command accordingly.
* As first execution asks you to do, edit configuration files. At least:
    * [unrealircd.conf](https://www.unrealircd.org/docs/Configuration_file_syntax): "oper", "cloak-keys", "set" and "listen" blocks (daemon will tell what's wrong in your current config... keep in mind that bitlbee's default port is 6667).
    * [bitlbee.conf](https://www.bitlbee.org/user-guide.html): auth parameters.
* Start the service.
* Go to ZNC's webadmin (port `7667`, user `admin`, pass `password`) and configure everything properly... starting by admins's password!

## Contributing
1. Fork it.
2. Create your feature branch (`git checkout -b feature/fooBar`).
3. Commit your changes (`git commit -am 'Add some fooBar'`).
4. Push to the branch (`git push origin feature/fooBar`).
5. Create a new Pull Request.

## Release History
* 0.0.1
    * Work in progress

## Meta
Daniel Prado – dpradom@argallar.com

Distributed under the GPLv3 license. See ``LICENSE`` for more information.

