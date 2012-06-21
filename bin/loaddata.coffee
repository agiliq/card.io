#!/usr/bin/env coffee

ARGV = process.argv[1..]  # Drop 'coffee' interpreter from arguments.
ARGC = ARGV.length

Deck = require('../models/deck')
Card = require('../models/card')

data = require "../#{ARGV[1]}" # Work with relative path

deck = new Deck({
    'name': data.name
})

deck.save()

for _card in data.cards
  do (_card) ->
    _card.deck = deck
    card = new Card(_card)
    card.save()

console.log "Saved deck #{deck.name} with #{data.cards.length} cards"

process.exit()
