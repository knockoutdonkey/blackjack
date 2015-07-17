class window.Hand extends Backbone.Collection
  model: Card

  # defaults: 
  #   "isWinner": undefined
  #   "isPlaying": true

  initialize: (array, @deck, @isDealer, @isWinner = false, @isPlaying = true) ->
    # @set "isWinner", undefined
    # @set "isPlaying", true

  hit: ->
    card = @deck.pop()
    @add(card)
    card
    if @scores()[0] > 21 then @stand()

  hasAce: -> @reduce (memo, card) ->
    memo or card.get('value') is 1
  , 0

  lose: -> 
    @isWinner = false
    @isPlaying = false

  minScore: -> @reduce (score, card) ->
    score + if card.get 'revealed' then card.get 'value' else 0
  , 0

  playOut: (otherScore)-> 
    @forEach (card)->
      if not card.get "revealed" then card.flip()

    if otherScore > 21 then return

    while @scores()[0] < otherScore
      @hit()

  scores: ->
    # The scores are an array of potential scores.
    # Usually, that array contains one element. That is the only score.
    # when there is an ace, it offers you two scores - the original score, and score + 10.
    [@minScore(), @minScore() + 10 * @hasAce()]

  stand: -> 
    @trigger "finished", @

  win: ->
    @isWinner = true
    @isPlaying = false