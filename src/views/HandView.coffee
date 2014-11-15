class window.HandView extends Backbone.View
  className: 'hand'

  template: _.template '<h2><% if(isDealer){ %>Dealer<% }else{ %>You<% } %> (<span class="score"></span>)</h2>'

  initialize: ->
    @collection.on 'remove reset', =>
      @render()
    @collection.on 'add', =>
      @renderAddedCard()
    @render()

  render: ->
    console.log "rerendering Handview"
    @$el.children().detach()
    @$el.html @template @collection
    @$el.append @collection.map (card) ->
      new CardView(model: card).$el
    score = @collection.scores()[0]

    if @collection.hasAce() and not @collection.hasCoveredAce() then score = @collection.scores().join ' or '

    @$('.score').text score

  renderAddedCard: ->
    newCard = @collection.at(@collection.length-1)
    newCardView = new CardView(model: newCard)
    @$el.append newCardView.$el
    newCardView.revealCard()
    score = @collection.scores()[0]

    if @collection.hasAce() and not @collection.hasCoveredAce() then score = @collection.scores().join ' or '

    @$('.score').text score
