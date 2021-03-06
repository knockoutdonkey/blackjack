class window.Hand extends Backbone.Collection
  model: Card

  dealerReveal: ->
    @.slice(1).forEach (card) ->
      card.flip()

  initialize: (array, @deck, @isDealer, @status="Playing") ->

  hit: ->
    card = @deck.draw()
    @add(card)
    if @score() > BJRules.MaxScore then @stand()
    card

  hasAce: -> @reduce (memo, card) ->
    memo or (card.get('value') is 1 and card.get 'revealed')
  , 0

  hasBlackJack: -> 
    if @length is 2
      ace = false
      ten = false
      @forEach (card)-> 
        console.log card
        if card.get("value") is 10 then ten = true
        if card.get("rankName") is "Ace" then ace = true
    ace and ten

  hide: ->
    @forEach (card)->
      if card.get "revealed" then card.flip()
  
  show: ->
    @forEach (card)->
      if not card.get "revealed" then card.flip()

  lose: -> 
    @status = "Loser"
    @trigger("change",@)

  minScore: -> @reduce (score, card) ->
    score + if card.get 'revealed' then card.get 'value' else 0
  , 0

  playOut: (otherScore)-> 
    @show()

    if otherScore is 0 return

    while @score() < BJRules.DealerMax
      @hit()

  score: ->
    # The scores are an array of potential scores.
    # Usually, that array contains one element. That is the only score.
    # when there is an ace, it offers you two scores - the original score, and score + 10.
    if @minScore() <= 11
      return @minScore() + 10 * @hasAce()
    return @minScore()
     

  stand: -> 
    @trigger "finished", @

  tie: ->
    @status = "Tie"
    @trigger("change",@)


  win: ->
    @status = "Winner"
    @trigger("change",@)