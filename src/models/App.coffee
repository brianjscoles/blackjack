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
    @listenTo @get('dealerHand'), 'stand', @gameEndedCheckFinalScores

  gameEndedPlayerOver21: ->
    @set 'gameEndCondition', 'You went over 21 - busted!'
    console.log ('game ends - player busts')
    @resetGameState()

  gameEndedDealerOver21: ->
    @set 'gameEndCondition', 'The dealer is bust!'
    console.log ('game ends - dealer busts')
    @resetGameState()



  startDealerTurn: ->
    console.log "App hears a 'stand' event and requests takeDealerTurn"
    @get('dealerHand').takeDealerTurn()

  gameEndedCheckFinalScores: ->
    console.log @get('playerHand').finalScore()
    console.log @get('dealerHand').finalScore()
    console.log ('game ends - best score wins')
    if @get('playerHand').finalScore() > @get('dealerHand').finalScore()
      @set 'gameEndCondition', 'You win!'
    else
      @set 'gameEndCondition', 'The dealer wins!'
    @resetGameState()


  resetGameState : ->
    @set 'isGameEnded', true
    @get('deck').reset()
    @get('playerHand').reset()
    @get('dealerHand').print()
    @get('dealerHand').reset()
    @get('dealerHand').print()
    @set 'isGameEnded', false

