redis = require('redis').createClient()

class Deck

  constructor: (attributes) ->
    @[key] = value for key,value of attributes

    if not @id and @name
      @id = @name.replace /\s/g, '-'

  save: (callback) ->
    redis.hset 'Deck', @id, JSON.stringify(@), (err, responseCode) =>
      callback null, @

  @all: (callback) ->
      redis.hgetall 'Deck', (err, objects) ->
        decks = []
        for key, value of objects
          deck = new Deck JSON.parse(value)
          decks.push deck
        callback null, decks

  @get: (id, callback) ->
    redis.hget 'Deck', id, (err, json) ->
        if json is null
          callback new Error("Pie '#{id}' could not be found.")
        deck = new Deck JSON.parse(json)
        callback null, deck


module.exports = Deck
