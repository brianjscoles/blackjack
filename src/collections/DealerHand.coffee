class window.DealerHand extends window.Hand

  takeDealerTurn: ->
    @at(0).flip()
    while @finalScore() < 20
      @hit()
      @trigger 'hit'
    if @finalScore() <= 21 then @stand() else @trigger('isOver21')


  hit: ->
    @add(@deck.pop())
