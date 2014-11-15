# TODO: Refactor this model to use an internal Game Model instead
# of containing the game logic directly.
class window.App extends Backbone.Model
  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    @set 'isGameEnded', false
    @set 'gameStatus', null
    @listenTo @get('playerHand'), 'isOver21', @gameEndedPlayerOver21
    @listenTo @get('playerHand'), 'stand', @startDealerTurn
    @listenTo @get('dealerHand'), 'isOver21', @gameEndedDealerOver21
    @listenTo @get('dealerHand'), 'stand', @gameEndedCheckFinalScores

  gameEndedPlayerOver21: ->
    @set 'gameStatus', 'You went over 21 - busted!'
    @set 'isGameEnded', true

  gameEndedDealerOver21: ->
    @set 'gameStatus', 'The dealer is bust!'
    @set 'isGameEnded', true



  startDealerTurn: ->
    @get('dealerHand').takeDealerTurn()

  gameEndedCheckFinalScores: ->
    if @get('playerHand').finalScore() > @get('dealerHand').finalScore()
      @set 'gameStatus', 'You win!'
    else
      @set 'gameStatus', 'The dealer wins!'
    @set 'isGameEnded', true


  resetGameState : ->
    @get('deck').reset()
    @get('playerHand').reset()
    @get('dealerHand').reset()
    @set 'isGameEnded', false
    @set 'gameStatus', 'It\'s your turn!'

