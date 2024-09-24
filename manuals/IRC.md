# IRC Manual

This manual describes connecting to a Nodes server using an IRC client.

## WeeChat

```
brew install weechat
weechat
```

## Prerequsists

On the servers you are connecting to, you will need to make sure that the "Username"
field is set to something which will become the NICK for that user.

Our implementation uses port 6667 which is the default and SSL, so set those options.


## Adding a server and setting your VID
```
/server add whatever whatever.com/6667 -tls
/set irc.server.whatever.password "Your VID"
```

## Connecting to a server:

```
/connect whatever
```

## Listing the channels

In nodes, we equate "Channels" to "Streams".

```
/list
```
The stream names have been lowercased, had the spaces changed to "+" and have a "#" at the start.

## Joining a stream

```
/join #welcome
```

## Sending a messages

Once you have joined a channel you can just type messages.