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
    @set 'playerHand', (@get 'deck').dealPlayer()
    @set 'dealerHand', (@get 'deck').dealDealer()
    @get('player').giveHand(@get 'playerHand')

    # @takeBets()
    @get('player').on "ready", =>


    @get('playerHand').on "finished", (hand) =>
      @get('dealerHand').playOut @get('playerHand').score()
      @decideWinner()
      console.log "finished event heard"

  # takeBets: ->
  #   @get('player').bet(10)

  decideWinner: ->
    console.log "decidedWinner"
    playerScore = @get('playerHand').score()
    dealerScore = @get('dealerHand').score()
    if (playerScore > dealerScore or dealerScore > 21) and playerScore <= 21
      @get('playerHand').win()
      @get('player').win()
      @get('dealerHand').lose()
      @set 'winner', @get('playerHand')

    else if playerScore is dealerScore
      @get('playerHand').tie()
      @get('player').tie()
      @get('dealerHand').tie()
      @set 'winner', @get('playerHand')

    else
      @get('playerHand').lose()
      @get('dealerHand').win()
      @set 'winner', @get('dealerHand')

  restart: ->
    @setUpGame()
    @set("winner", null)
