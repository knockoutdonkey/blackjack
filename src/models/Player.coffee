class window.Player extends Backbone.Model

  # phases are: betting, ready

  defaults:
    chips: 500
    bet: 0
    phase: "betting"

  initialize: ->

  giveHand: (hand) ->
    @set 'hand', hand
    @get('hand').on 'finished', =>
      @stand()

  bet: (amount) ->
    console.log amount
    if @get("phase") is "betting"
      if amount <= @get 'chips'
        @set "bet", Number(amount)
        @set "chips", (@get "chips") - @get "bet"
        @set "phase", "ready"
        @get("hand").show()
        @trigger("ready",@)

  lose: ->
    @get('hand').lose()
    @set 'phase', 'betting'

  hit: ->
    console.log(@get "phase")
    if @get("phase") is "playing"
      @get("hand").hit()

  play: ->
    @set 'phase', 'playing'

  stand: ->
    if @get("phase") is "playing"
      @set 'phase', 'finished'
      @trigger 'finished', @

  tie: ->
    @get('hand').tie()
    @set 'phase', 'betting'
    @set "chips", @get("chips") + @get("bet")

  win: ->
    @get('hand').win()
    @set 'phase', 'betting'
    if @get('hand').hasBlackJack()
      @set "chips", (@get("chips") + Math.floor(@get("bet") * BJRules.BlackJackBonus))
    else
      @set "chips", @get("chips") + @get("bet") * BJRules.NormalBonus

  score: ->
    @get('hand').score()