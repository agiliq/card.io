redis = require('redis').createClient()

log = () -> null

class Card

  constructor: (attributes) ->
    @[key] = value for key,value of attributes

    if not @id and @name
      @id = @name.replace /\s/g, '-'

  save: (callback=log) ->
    redis.hset 'Card', @id, JSON.stringify(@), (err, responseCode) =>
      callback null, @

  @all: (callback) ->
      redis.hgetall 'Card', (err, objects) ->
        cards = []
        for key, value of objects
          card = new Card JSON.parse(value)
          cards.push card
        callback null, cards

  @get: (id, callback) ->
    redis.hget 'Card', id, (err, json) ->
        if json is null
          callback new Error("Card '#{id}' could not be found.")
        card = new Card JSON.parse(json)
        callback null, card


module.exports = Card
