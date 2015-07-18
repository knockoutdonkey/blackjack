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
    @set 'dealerHand', (@get 'deck').dealDealer()
    @get('player').giveHand(hand)

    # @takeBets()
    @get('player').on "ready", =>


    hand.on "finished", (hand) =>
      @get('dealerHand').playOut hand.score()
      @decideWinner()
      console.log "finished event heard"

  # takeBets: ->
  #   @get('player').bet(10)

  decideWinner: ->
    console.log "decidedWinner"
    playerScore = @get('player').score()
    dealerScore = @get('dealerHand').score()
    if (playerScore > dealerScore or dealerScore > BJRules.MaxScore) and playerScore <= BJRules.MaxScore
      @get('player').win()
      @get('dealerHand').lose()
      @set 'winner', @get('player')

    else if playerScore is dealerScore
      @get('player').tie()
      @get('dealerHand').tie()
      @set 'winner', @get('player')

    else
      @get('player').lose()
      @get('dealerHand').win()
      @set 'winner', @get('dealerHand')

  restart: ->
    @setUpGame()
    @set("winner", null)
