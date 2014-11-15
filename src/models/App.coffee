# TODO: Refactor this model to use an internal Game Model instead
# of containing the game logic directly.
class window.App extends Backbone.Model
  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    @set 'isGameEnded', false
    @set 'gameEndCondition', null
    @listenTo @get('playerHand'), 'isOver21', @gameEndedOver21

  gameEndedOver21: ->
    @set 'isGameEnded', true
    @set 'gameEndCondition', 'over21'




