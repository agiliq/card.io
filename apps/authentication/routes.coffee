Deck = require '../../models/deck'

routes = (app) ->

  app.get '/', (req, res) ->
    if not req.session.currentUser
      res.redirect '/login'
    res.redirect '/welcome'

  app.get '/login', (req, res) ->
    if req.session.currentUser
      res.end '<a href="/logout">Logout</a>'
    res.render "#{__dirname}/views/login",
      title: 'Login'

  app.post '/login', (req, res) ->
    if req.body.nick
      req.session.currentUser = req.body.nick
      res.redirect '/welcome'
      return
    req.redirect '/login'

  app.get '/logout', (req, res) ->
    req.session.regenerate (err) ->
      res.redirect '/login'

  app.get '/welcome', (req, res) ->
    if not req.session.currentUser
      res.redirect '/login'
    Deck.all (err, decks) ->
      res.render "#{__dirname}/views/welcome",
        title: 'Welcome'
        user: req.session.currentUser
        decks: decks

  app.get '/game', (req, res) ->
    if not req.session.currentUser
      res.redirect '/login'
    res.end 'start!'

module.exports = routes
