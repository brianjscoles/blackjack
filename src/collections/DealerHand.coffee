class window.DealerHand extends window.Hand

  takeDealerTurn: ->
    @at(0).flip()
    while @minScore() < 17
      @hit()
    if @minScore() <= 21 then @stand()
