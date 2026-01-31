------------------------------------------------------------------------------------------------------
QUANTUM Messenger Pro 0.4.6
------------------------------------------------------------------------------------------------------

How to use:

In the local base version without a coordination module, you need to find out your opponent's IP, your own IP, and communicate it to your opponent for setup.
    The messenger in this configuration will only work on local networks, which is convenient for enterprises,
    including for maintaining the confidentiality of work correspondence and preventing data leaks to the external
    network.
In the full PRO version, the IP address is obtained by the messenger automatically during synchronization and connection with another user.

The program by default uses port 443, therefore messages must be sent to this port.

During operation, the program requests the recipient's IP address from the IP address input field.
By default, the address is set to your local machine 127.0.0.1.
    If immediately after launch you simply write a message in the message composition field, it goes to
    the general list, and you receive an echo response, it means
    the program is operational.

If you are working on a local network, you need to specify the recipient's IP address in the field, after which
messages will be sent to this IP address.
    If you have synchronized with the server and the second user is offline, then in the message field,
upon sending, a note will appear stating that the message has been saved for the user on the server.
In the general field, messages from your собеседников will appear.
    After closing the program, the IP, PORT, and Username settings are saved in the configuration file,
    and are loaded from the config upon the next launch.

For the program to work, simply allow network access in the firewall during the first launch.

Advantages of the QUANTUM Messenger:
------------------------------------------------------------------------------------------------------
  0. The classic Windows interface provides good backward compatibility and saves PC resources.

  1. The messenger is absolutely clean and honest, only direct connections.

  2. No service information is transmitted anywhere except to your собеседник's client.

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

        Minimum system requirements: CPU Pentium 32 Bit, 512 MB RAM, WindowsXP
----------------------------------------------------------------------------------------- 
 - Bug fixes
 - Code Optimization
 -----------------------------------------------------------------------------------------
Changes History:

0.2.4
- Enanche interface

0.2.5
- Add send/receive system info (ip:port)

0.2.6
 - Interface improvements

0.2.7
 - Automatic getting ip:port from you talk-unit on first message received

0.2.8
 - Popup window messenger behavior on msg receive

0.2.9
 - Add receive message signal

0.3.0
 - Work p2p in internet

0.3.4
 - Synchronize dynamicaly changed ip addreses in current session

0.3.5
 - delivery offline message

0.3.6
 - Last message view autofocus and scroll to him

0.3.7 
 - interface, text and font improvements (always on top option, nice readable font, formating message text)

0.3.8
 - Standart Scrolling mechanism upgraded to Cacheble for rolling bug fixes and better flow

0.3.9
 - Remove some connections lags (need testing stability) plus someone bug fixes and optimizes approved

0.4.0
 - File send/receive functions implemented

0.4.1
 - Add send/recv progressbar

0.4.5
 -  Error corections algoritms added for send receive files. SSE2 optimization implemented!
 -  ini file parse for configure and load server adresses/ports/lastlogins on startup messenger
 -  (for client and server add) user online check and keep alive mode for keep channel to waiting you friend session
 -  delivery condenced messages for you while you still offline (from server)

0.4.6
 -  Some optimization and stability filesend issues fix

---------- in plan:
   - chat history local datafile
   - voice message-file send
   - userlist implement/parse data file & restore chat
   
 or more...

 Possible Issues:

    Application window freezes when exiting (can occur before synchronization and/or message exchange)
    (This happens due to a specific behavior related to timer handling and will be fixed in future versions)

    One client unsuccessfully tries to send messages or a file to another.
    Cause: Additional port blocking on the network route on the opposite side.
    Fix: Send a small file and a message from the non-responding side.

    Lack of connection is also possible due to blocking by internet providers.
    Solution: Use a VPN with support for the UDP protocol.

Installing a coordination server for work outside the local network
(The server was tested on CentOS 7):

To install, place the serverXX file in the folder /opt/msgserver/.
Ensure that UDP ports 443 and 4443 are open on the server.
The server must have a direct (public) IP if it is located on the internet.

Place the service file in /usr/lib/systemd/system/msgserver.service
and install it using the commands:

    systemctl enable msgserver
    systemctl start msgserver

The service file is also included (attached in the package); other paths can be configured there as well.
Ensure the server file has execute permissions: chmod 755.
Upon startup, the server creates two MySQL-format databases in its folder.
These can be deleted if necessary, after which the server should be restarted.
The server also enables deferred message delivery by storing messages in the database until they are sent.
 



