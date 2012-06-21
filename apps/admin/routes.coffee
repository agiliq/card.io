Deck = require '../../models/deck'
Card = require '../../models/card'

module.exports = (app) ->

  # Authentication check
  app.all '/admin/*', (req, res, next) ->
    if not (req.session.currentUser)
      res.redirect '/login'
      return
    next()

  app.get '/admin/', (req, res) ->
    res.redirect '/admin/decks/'

  # List all decks.
  app.get '/admin/decks/', (req, res) ->
    Deck.all (err, decks) ->
      res.render "#{__dirname}/views/decks",
        title: 'Decks'
        decks: decks

  app.get '/admin/decks/:id', (req, res) ->
    Deck.get req.params.id, (err, deck) ->
      res.render "#{__dirname}/views/deck",
        title: deck.name
