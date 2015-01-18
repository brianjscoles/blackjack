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

  flipInitialCards: ->
    @get('playerHand').at(0).flip()
    @get('playerHand').at(1).flip()
    @get('dealerHand').at(1).flip()

  startDealerTurn: ->
    @set 'gameStatus', 'It\'s the dealer\'s turn!'
    @get('dealerHand').takeDealerTurn(@get('playerHand').finalScore())

  gameEndedPlayerOver21: ->
    @set 'gameStatus', 'You busted - the dealer wins!'
    @set 'isGameEnded', true

  gameEndedDealerOver21: ->
    @set 'gameStatus', 'The dealer busted - you win!'
    @set 'isGameEnded', true



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
    @flipInitialCards()

