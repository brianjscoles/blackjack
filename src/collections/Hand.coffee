class window.Hand extends Backbone.Collection
  model: Card

  initialize: (array, @deck, @isDealer) ->

  hit: ->
    @add(@deck.pop())
    if @minScore() > 21
      @trigger('isOver21')

  stand: ->
    @trigger('stand')


  hasAce: -> @reduce (memo, card) ->
    memo or card.get('value') is 1
  , 0

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
    if @isDealer then console.log "this is the dealer's hand." else console.log "this is the player's hand."
    console.log "resetting hand. length is now " + @length
    @hit()
    @hit()
    if @isDealer then @at(0).flip()

  print: ->
    @forEach (elem) ->
      console.log elem.get('rankName') + " of " + elem.get('suitName')

