class window.Deck extends Backbone.Collection
  model: Card

  initialize: ->
    @makeDeck()

  dealPlayer: ->
    playerHand = new Hand null, @, false
    playerHand.deal()
    playerHand.deal()
    playerHand

  dealDealer: ->
    dealerHand = new DealerHand null, @, true
    dealerHand.deal()
    dealerHand.deal()
    dealerHand

  reset: ->
    Backbone.Collection.prototype.reset.call @
    @makeDeck()

  makeDeck: ->
    @add _([0...52]).shuffle().map (card) ->
      new Card
        rank: card % 13
        suit: Math.floor(card / 13)
