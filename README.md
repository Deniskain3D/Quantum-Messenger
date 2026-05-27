------------------------------------------------------------------------------------------------------
QUANTUM Messenger Pro 0.5.6 (beta)
------------------------------------------------------------------------------------------------------
Download lastest: https://github.com/Deniskain3D/Quantum-Messenger/releases

How to use:

In the local base version without a coordination module, you need to find out your opponent's IP, your
    own IP, and communicate it to your opponent for setup.
    The messenger in this configuration will only work on local networks, which is convenient for enterprises,
    including for maintaining the confidentiality of work correspondence and preventing data leaks to the
	external network.
	(Actualy you may have internet connection if one of you pair have static external IP)
In the PRO version, the IP address is obtained by the messenger automatically during synchronization and
    connection with another user
    (sincle now you may use simple or pro pack whorewer you want, all this include there.)
    The program by default uses port 443, therefore messages must be sent to this port.

During operation, the program requests the recipient's IP address from the IP address input field.
By default, the address is set to your local machine 127.0.0.1.
    If immediately after launch you simply write a message in the message composition field, it goes to
    the general list, and you receive an echo response, it means
    the program is operational.

If you are working on a local network, you need to specify the recipient's IP address in the field, after which
messages will be sent to this IP address.by push SEND button

    If you have server IP writed in qset.ini file, and want make internet connection, at the start, push SYNC button
    to synchronize with in server and after you can send message. If the second user is offline, then in the message
    field, upon sending, a note that the message has been saved for his user on the server.
    In the general field, messages from your recipient's will appear.
    After closing the program, the IP, PORT, and Username settings have been saves to configuration file,
    and are loaded from theese config upon the next launch.

For localnet fileexchange (without server) check for you and your pair have symetrical fileport use in qset.ini file

For the first start program, simply allow network access in the firewall during launch.

Advantages of the QUANTUM Messenger:
------------------------------------------------------------------------------------------------------
  0. The classic Windows interface provides good backward compatibility and saves PC resources.

  1. The messenger is absolutely clean and honest, only direct connections.

  2. No service information is transmitted anywhere except to your recipient's client.

  3. The messenger takes up mere kilobytes; there is no extra or spyware functionality at all.

  4. No logging of connections, IP addresses, MAC addresses, ID identifiers on a third party.

  5. Message history is not stored (in future versions, this feature can be enabled manually).

  6. Flexibility in connections: if one port is blocked, another can be used.

  7. The protocol is low-level and always works on the internet, unlike other messengers.

  8. No registration via phone, email, or ID, meaning there is no binding or identifiable fingerprints.

  9. Controllable confidentiality: In popular web-based messengers, you do not get
    confidentiality for several reasons: communication goes through intermediate servers,
    your own browser fingerprints (it is technically impossible to block all browser leaks
    as technologies constantly change and you do not control this).

 10. Easy setup of your own coordination module (simply run it under Linux and it works).

 11. The program has several independent threads that run on their own
     processor cores with their own set of registers. To improve
     performance and stability, a processor with
     4 cores is optimally recommended for the program's operation.

        The messenger is conditionally free for private use.
        If you wish to support the author for future improvements,
        payment details and contact information are in the About section.

  Minimum system requirements:
  CPU Pentium IV(32bit Willamette core with SSE2 instructions), 512 MB RAM, WindowsXP32
----------------------------------------------------------------------------------------- 
 - New Features
 - Bug fixes
 - Code Optimization
 -----------------------------------------------------------------------------------------
Changes History:

0.2.4 - Enanche interface

0.2.5 - Add send/receive system info (ip:port)

0.2.6 - Interface improvements

0.2.7 - Automatic getting ip:port from you talk-unit on first message received

0.2.8 - Popup window messenger behavior on msg receive

0.2.9 - Add receive message signal

0.3.0 - Work p2p in internet

0.3.4 - Synchronize dynamicaly changed ip addreses in current session

0.3.5 - delivery offline message

0.3.6 - Last message view autofocus and scroll to him

0.3.7 - interface, text and font improvements (always on top option, nice readable font, formating message text)

0.3.8 - Standart Scrolling mechanism upgraded to Cacheble for rolling bug fixes and better flow

0.3.9 - Remove some connections lags (need testing stability) plus someone bug fixes and optimizes approved

0.4.0 - File send/receive functions implemented

0.4.1 - Add send/recv progressbar

0.4.5 - Error corections algoritms added for send receive files. SSE2 optimization implemented!
		Ini file parse for configure and load server adresses/ports/lastlogins on startup messenger.
		For client and server - add user online check and keep alive mode for keep channel to waiting
		you friend session. Delivery condenced messages for you while you still offline (from server)

0.4.6 -  Some optimization and stability filesend issues fix

0.4.7 -  Bug fix, filesend stability improving

0.4.8 - Many small changes emproves, stables and fixes for filexchange (add some retryes, etc.)
        add logout info about this
   
0.5.0 - optimizes/bugfix
        add protection for missing mirror traffic received

0.5.1 - improved cryptografy and stability make better baselogic architecture

0.5.2 - add message and filesend supples from other side with indication /some fixes

0.5.3 - change delivery indicator to star symbol / bugfix /optimizes

0.5.4 - add check for correct message delivery (red/green star-color)

0.5.5 - filesend deeper error correction / add listbox message clipboard/
        add reply function / textinput bugfix /compact delivery-star to lastmsg/
		add more text formating accuracy / fix mem alloc interface freeze across separate thread

0.5.6 - voice message function added / ole and some other small bug fix / add buton icons

---------- in plan i think made or not:

   - chat history local datafile
   - userlist implement/parse data file & restore chat
   - video call's
   
 or some more...
------------------------------------------------------------------------------------------------------------------
 Possible Issues:

        Application window may have freezes and loose control when restart in current aproved p2p session
    (can occur if you receive ping from parthner before first synchronization and/or message exchange)
    (This happens due to a specific behavior related to timer handling and will be fixed
    in future versions). For complete it, restart messenger and make some connection first time or send any message
    to current ip before you receive external ping. (monitor it in logfile)
          Sometimes program may send empty message, it`s ping, which displayed in message window against log window,
    i seek now for this bug..
    One client unsuccessfully tries to send messages or a file to another.
    Cause: Additional port blocking on the network route on the opposite side.
    Fix: Send a small file and a message from the non-responding side.

    Lack of connection is also possible due to blocking by internet providers.
    Solution: Use a VPN with support for the UDP protocol.

------------------------------------------------------------------------------------------------------------------
Installing a coordination server for work outside the local network
(The server was tested on CentOS 7):

To install, place the serverXX file in the folder '/opt/msgserver/'

install MariaDB or some MySQL compatible DB

install python 3.x if you not have

(for centOS: sudo yum install python3)

Ensure that UDP ports 443 and 4443 are open on the server.
The server must have a direct (public) IP if it is located on the internet.
This address and server ports must be writen in client's qset.ini configuration file
For permanent server runwork, modify at you own and place 'msgserver.service' template file
to '/usr/lib/systemd/system/' and install it using the commands:

systemctl enable msgserver

systemctl start msgserver

The service file is also included (attached in the package); other paths can be configured there as well.
Ensure the server file has execute permissions: chmod 755.
Upon startup, the server creates two MySQL-format databases in serverfile folder.
These can be deleted if necessary, after which the server should be restarted.
The server also enables deferred message delivery by storing crypted messages in the database until they are sent.
