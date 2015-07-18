class window.Hand extends Backbone.Collection
  model: Card

  # defaults: 
  #   "isWinner": undefined
  #   "isPlaying": true

  initialize: (array, @deck, @isDealer, @status="Playing") ->

  hit: ->
    card = @deck.draw()
    @add(card)
    card
    if @score() > BJRules.MaxScore then @stand()

  hasAce: -> @reduce (memo, card) ->
    memo or card.get('value') is 1
  , 0

  hasBlackJack: -> 
    if @length is 2
      ace = false
      ten = false
      @forEach (card)-> 
        if card.value is 10 then ten is true
        if card.rankName is "Ace" then ace is true
    ace and ten



  lose: -> 
    @status = "Loser"

  minScore: -> @reduce (score, card) ->
    score + if card.get 'revealed' then card.get 'value' else 0
  , 0

  playOut: (otherScore)-> 
    @forEach (card)->
      if not card.get "revealed" then card.flip()

    if otherScore > BJRules.MaxScore then return

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

  win: ->
    @status = "Winner"