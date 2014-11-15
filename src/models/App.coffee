# TODO: Refactor this model to use an internal Game Model instead
# of containing the game logic directly.
class window.App extends Backbone.Model
  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    @set 'isGameEnded', false
    @set 'gameEndCondition', null
    @listenTo @get('playerHand'), 'isOver21', @gameEndedPlayerOver21
    @listenTo @get('playerHand'), 'stand', @startDealerTurn
    @listenTo @get('dealerHand'), 'isOver21', @gameEndedDealerOver21
    @listenTo @get('dealerHand'), 'stand', @checkFinalScores

  gameEndedPlayerOver21: ->
    @set 'gameEndCondition', 'You went over 21!'
    @set 'isGameEnded', true
    @get('deck').reset()
    @get('playerHand').reset()
    @get('dealerHand').reset()
    @set 'isGameEnded', false

  gameEndedDealerOver21: ->
    @set 'gameEndCondition', 'The dealer went over 21!' ##TODO
    @set 'isGameEnded', true
    @get('deck').reset()
    @get('playerHand').reset()
    @get('dealerHand').reset()
    @set 'isGameEnded', false

  startDealerTurn: ->
    @get('dealerHand').takeDealerTurn()

  checkFinalScores: ->
    if @get('playerHand').minScore() < @get('dealerHand').minScore()
      @set 'gameEndCondition', 'You win!'
    else
      @set 'gameEndCondition', 'The dealer wins!'
    @set 'isGameEnded', true

