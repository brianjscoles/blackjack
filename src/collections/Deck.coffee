class window.Deck extends Backbone.Collection
  model: Card

  initialize: ->
    @makeDeck()

  dealPlayer: -> new Hand [@pop(), @pop()], @, false

  dealDealer: -> new DealerHand [@pop().flip(), @pop()], @, true

  reset: ->
    Backbone.Collection.prototype.reset.call @
    @makeDeck()

  makeDeck: ->
    @add _([0...52]).shuffle().map (card) ->
      new Card
        rank: card % 13
        suit: Math.floor(card / 13)
