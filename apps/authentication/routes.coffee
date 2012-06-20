routes = (app) ->

  app.get '/', (req, res) ->
    if not req.session.currentUser
      res.redirecet '/login'
    res.redirect '/cards'

  app.get '/login', (req, res) ->
    if req.session.currentUser
      res.end '<a href="/logout">Logout</a>'
    res.render "#{__dirname}/views/login",
      title: 'Login'

  app.post '/login', (req, res) ->
    if req.body.nick
      req.session.currentUser = req.body.nick
      res.redirect '/cards'
      return
    req.redirect '/login'

  app.get '/logout', (req, res) ->
    req.session.regenerate (err) ->
      res.redirect '/login'

  app.get '/cards', (req, res) ->
    res.end "Hello #{req.session.currentUser}"

module.exports = routes
