class window.Hand extends Backbone.Collection
  model: Card

  initialize: (array, @deck, @isDealer) ->

  hit: ->
    @add(@deck.pop())
    @trigger('hit')
    if @minScore() > 21
      @trigger('isOver21')

  deal: ->
    @add(@deck.pop())

  stand: ->
    @trigger('stand')


  hasAce: -> @reduce (memo, card) ->
    memo or card.get('value') is 1
  , 0

  hasCoveredAce: ->
    @at(0).get('rankName') is 'ace' and not @at(0).get('revealed')

  minScore: -> @reduce (score, card) ->
    score + if card.get 'revealed' then card.get 'value' else 0
  , 0

  finalScore: ->
    #scores is a tuple representing [score, score with aces]
    scores = @scores()
    if scores[1] <= 21 then return scores[1] else return scores[0]

  scores: ->
    # The scores are an array of potential scores.
    # Usually, that array contains one element. That is the only score.
    # when there is an ace, it offers you two scores - the original score, and score + 10.
    [@minScore(), @minScore() + 10 * @hasAce()]

  reset: ->
    Backbone.Collection.prototype.reset.call @
    @deal()
    @deal()
    @trigger 'reset'

  print: ->
    @forEach (elem) ->
      console.log elem.get('rankName') + " of " + elem.get('suitName')

