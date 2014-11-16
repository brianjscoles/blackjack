class window.DealerHand extends window.Hand

  takeDealerTurn: (scoreToBeat)->
    @at(0).flip()
    @considerAnotherHit(scoreToBeat)



  hit: ->
    @add(@deck.pop())

  keepHitting: (scoreToBeat)->
    @hit()
    @trigger 'hit'
    @considerAnotherHit(scoreToBeat)

  considerAnotherHit: (scoreToBeat)->
    if @finalScore() < 17 and @finalScore() < scoreToBeat
      setTimeout(_.bind(@keepHitting, @, scoreToBeat), 500)
    else if @finalScore() <= 21 then @stand() else @trigger('isOver21')
