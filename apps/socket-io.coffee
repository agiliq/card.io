module.exports = (app) ->
  io = require('socket.io').listen(app)
  unless app.settings.socketIO
    app.set 'io', io

  nicknames = {}

  io.sockets.on 'connection', (socket) ->
    socket.on 'user message', (msg) ->
      socket.broadcast.emit 'user message', socket.nickname, msg

    socket.on 'nickname', (nick, fn) ->
      if nick in nicknames
        fn true
      else
        fn false
        nicknames[nick] = socket.nickname = nick
        socket.broadcast.emit 'announcement', nick + ' connected'
        io.sockets.emit 'nicknames', nicknames

    socket.on 'disconnect', () ->
      if not socket.nickname
        return

      delete nicknames[socket.nickname]
      socket.broadcast.emit 'announcement', socket.nickname + ' disconnected'
      socket.broadcast.emit 'nicknames', nicknames
