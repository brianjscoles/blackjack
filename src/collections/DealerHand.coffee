class window.DealerHand extends window.Hand

  takeDealerTurn: ->
    console.log "taking dealers turn now"
    @at(0).flip()
    while @finalScore() < 20
      console.log "dealer says HIT"
      @hit()
    if @finalScore() <= 21 then @stand() else @trigger('isOver21')


  hit: ->
    @add(@deck.pop())
