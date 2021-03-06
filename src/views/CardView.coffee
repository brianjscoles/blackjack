class window.CardView extends Backbone.View
  className: 'card'


  getAddress: ->
    return 'img/PNG-cards/' +  @model.attributes.rankName + "_of_" + @model.attributes.suitName + ".png"

  initialize: ->
    @render()
    @listenTo @model, 'change:revealed', @revealCard

  revealCard: (e)->
    @$el.find('.image').animate({"width": "0"},250,@revealCardPart2.bind(@))

  revealCardPart2: ->
    @$el.find('.image').css {'background-image': ('url(' + @getAddress() + ')')}
    @$el.find('.image').animate({"width": "100%"},250)



  events:
    'click': ->
      console.log 'You clicked me!'
      console.log @
      console.log @$el
      @revealCard()

  render: ->
    @$el.children().detach()
    @$el.html('<div class="image"></div>')
    @$el.find('.image').css("background-image", 'url(img/PNG-cards/card-back-red-0.png)');

