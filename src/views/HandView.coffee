class window.HandView extends Backbone.View
  className: 'hand'

  template: _.template '<h2><% if(isDealer){ %>Dealer\'s hand<% }else{ %>Your hand<% } %>: <span class="score"></span> points</h2>'

  initialize: ->
    @collection.on 'remove reset', =>
      @render()
    @collection.on 'hit', =>
      @renderAddedCard()
    @collection.on 'change', =>
      @renderScore()
    @render()

  render: ->
    @$el.children().detach()
    @$el.html @template @collection
    @$el.append @collection.map (card) ->
      new CardView(model: card).$el
    @renderScore()

  renderAddedCard: ->
    newCard = @collection.at(@collection.length-1)
    newCardView = new CardView(model: newCard)
    @$el.append newCardView.$el
    newCard.flip()
    @renderScore()

  renderScore: ->
    score = @collection.scores()[0]
    if @collection.hasAce() and not @collection.hasCoveredAce() then score = @collection.scores().join ' or '
    @$('.score').text score
