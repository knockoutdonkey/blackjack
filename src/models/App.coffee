# TODO: Refactor this model to use an internal Game Model instead
# of containing the game logic directly.
class window.App extends Backbone.Model

  defaults:
    'winner': null

  initialize: ->
    @set 'player', new Player()
    @set 'deck', deck = new Deck()
    @setUpGame()

  setUpGame: ->
    hand = (@get 'deck').dealPlayer()
    hand.hide()
    @set 'dealerHand', dealerHand = (@get 'deck').dealDealer()
    dealerHand.hide()
    @get('player').giveHand(hand)

    @get('player').on "ready", =>
      dealerHand.dealerReveal()

    hand.on "finished", (hand) =>
      @get('dealerHand').playOut hand.score()
      @decideWinner()
      console.log "finished event heard"


  decideWinner: ->
    console.log "decidedWinner"
    playerScore = @get('player').score()
    dealerScore = @get('dealerHand').score()
    if (playerScore > dealerScore or dealerScore > BJRules.MaxScore) and playerScore <= BJRules.MaxScore
      @get('player').win()
      @get('dealerHand').lose()
      # @set 'winner', @get('player')

    else if playerScore is dealerScore
      @get('player').tie()
      @get('dealerHand').tie()
      # @set 'winner', @get('player')

    else
      @get('player').lose()
      @get('dealerHand').win()
      # @set 'winner', @get('dealerHand')

  restart: ->
    @get('player').lose()
    @setUpGame()
    @set("winner", null)
