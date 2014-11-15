class window.CardView extends Backbone.View
  className: 'card'

  # template: _.template '<%= rankName %> of <%= suitName %>'

  getAddress: ->
    return 'img/PNG-cards/' +  @model.attributes.rankName + "_of_" + @model.attributes.suitName + ".png"

  initialize: -> @render()

  render: ->
    @$el.children().detach()
    # @$el.html
    @$el.css("background-image", 'url(' + @getAddress() + ')');
    @$el.addClass 'covered' unless @model.get 'revealed'

