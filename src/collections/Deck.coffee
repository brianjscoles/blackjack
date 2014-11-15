class window.Deck extends Backbone.Collection
  model: Card

  initialize: ->
    @makeDeck()

  dealPlayer: ->
    playerHand = new Hand null, @, false
    playerHand.hit()
    playerHand.hit()
    playerHand

  dealDealer: ->
    dealerHand = new DealerHand null, @, true
    dealerHand.hit()
    dealerHand.at(0).flip()
    dealerHand.hit()
    dealerHand

  reset: ->
    Backbone.Collection.prototype.reset.call @
    @makeDeck()

  makeDeck: ->
    @add _([0...52]).shuffle().map (card) ->
      new Card
        rank: card % 13
        suit: Math.floor(card / 13)
