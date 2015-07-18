class window.Player extends Backbone.Model

  # phases are: betting, ready

  defaults:
    chips: 500
    bet: 0
    phase: "betting"

  initialize: ->

  giveHand: (hand) ->
    @set 'hand', hand

  bet: (amount) ->
    if @get("phase") is "betting"
      if amount <= @get 'chips'
        @set "bet", amount
        @set "chips", (@get "chips") - @get "bet"
        @set "phase", "ready"

  lose: ->
    @get('hand').lose()
    @set 'phase', 'betting'

  hit: ->
    console.log(@get "phase")
    if @get("phase") isnt "betting"
      @get("hand").hit()

  stand: ->
    if @get("phase") isnt "betting"
      @get('hand').stand()

  tie: ->
    @set "chips", @get("chips") + @get("bet")
    @get('hand').tie()
    @set 'phase', 'betting'

  win: ->
    if @get('hand').hasBlackJack()
      @set "chips", (@get("chips") + Math.floor(@get("bet") * BJRules.BlackJackBonus))
    else
      @set "chips", @get("chips") + @get("bet") * BJRules.NormalBonus
    @get('hand').win()
    @set 'phase', 'betting'

  score: ->
    @get('hand').score()