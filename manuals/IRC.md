# IRC Manual

This manual describes connecting to a Nodes server using an IRC client.

## Prerequsists

On the servers you are connecting to, you will need to make sure that the "Username"
field is set to something which will become the NICK for that user.

Our implementation uses port 6667 which is the default and SSL, so set those options.

## Connecting to a server:

```
> SERVER whatever.com
> PASS (your VID)
USER   nodesdev.visualops.com :
< :localhost 001 yournick :Welcome
< :localhost 002 yournick :Your host is localhost running version 1
< :localhost 004 yournick Nodes IRC 1.4, 23-Sep-2024.
< :localhost MODE yournick +w
```

Where "yournick" is the Username for the server. There is no need to do a "NICK" command.

## Listing the channels

In nodes, we equate "Channels" to "Streams".

```
> LIST
< :localhost 321 yournick Channel :Users Name
< :localhost 322 yournick #login+messages 0
< :localhost 322 yournick #welcome 0
< :localhost 323 yournick :End of /LIST
```

The stream names have been lowercased, had the spaces changed to "+" and have a "#" at the start.

## Joining a stream

```
> JOIN #welcome
< :yournick!yournick@yournick JOIN #welcome yournick :Your fullname

> WHO #welcome
< :localhost JOIN #welcome yournick :Your fullname
< :localhost 331 yournick #welcome :No topic is set.
```

## Sending a messages

```
> PRIVMSG #welcome :Hi
< :paulh!paulh@paulh PRIVMSG #welcome :Hi
```
