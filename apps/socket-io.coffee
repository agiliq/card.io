module.exports = (app) ->
  socketIO = require('socket.io').listen(app)
  unless app.settings.socketIO
    app.set 'socketIO', socketIO

  # Example data
  socketIO.of('/decks').on 'connection', (socket) ->
    socket.on 'deck', (data) ->
      console.log data
      socket.emit 'deck',
        data: 'data'
      
  socketIO.of('/cards').on 'connection', (socket) ->
    socket.on 'card', (data) ->
      console.log data
    socket.emit 'card',
      data: 'data'
