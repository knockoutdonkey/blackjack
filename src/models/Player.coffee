class window.Player extends Backbone.Model

  defaults:
    chips: 500
    bet: 0

  initialize: ->

  giveHand: (hand) ->
    @set 'hand', hand

  bet: (amount) ->
    @set "bet", amount
    @set "chips", (@get "chips") - @get "bet"

  win: ->
    if @get('hand').hasBlackJack()
      @set "chips", (@get("chips") + Math.floor(@get("bet") * 2.5))
    else
      @set "chips", @get("chips") + @get("bet") * 2
