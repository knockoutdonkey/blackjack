class window.Deck extends Backbone.Collection
  model: Card

  initialize: ->
    @add _([0...52]).shuffle().map (card) ->
      new Card
        rank: card % 13
        suit: Math.floor(card / 13)

  dealPlayer: -> new Hand [@draw(), @draw()], @

  dealDealer: -> new Hand [@draw().flip(), @draw()], @, true

  draw: ->
    if @length is 0
      @initialize()
    @pop()