class window.AppView extends Backbone.View
  template: _.template '
    <div class="status-bar">It\'s your turn!</div>
    <button class="hit-button active">Hit</button>
    <button class="stand-button active">Stand</button>
    <button class="reset-button">New Game</button>
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
  '

  events:
    'click .hit-button.active': -> @model.get('playerHand').hit()
    'click .stand-button.active': -> @model.get('playerHand').stand()
    'click .reset-button': ->
      @model.resetGameState()
      @$el.find('button').toggleClass('active')

  initialize: ->
    @render()
    @listenTo @model, 'change:isGameEnded', @signalEndOfGame
    @listenTo @model, 'change:gameStatus', @updateGameStatus
    @model.flipInitialCards()


  render: ->
    @model.get('playerHand').someMethod
    @$el.children().detach()
    @$el.html @template()
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el

  signalEndOfGame: ->
    if @model.get 'isGameEnded'
      @$el.find('button').toggleClass('active')

  updateGameStatus: ->
    @$el.find('.status-bar').text(@model.get('gameStatus'))
