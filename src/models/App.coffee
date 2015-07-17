# TODO: Refactor this model to use an internal Game Model instead
# of containing the game logic directly.
class window.App extends Backbone.Model

  defaults:
    'winner': null

  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    @get('playerHand').on "finished", (hand) =>
      @get('dealerHand').playOut @get('playerHand').scores()[0]
      @decideWinner()
      console.log "finished event heard"

  decideWinner: ->
    console.log "decidedWinner"
    playerScore = @get('playerHand').scores()[0]
    dealerScore = @get('dealerHand').scores()[0]
    if (playerScore > dealerScore or dealerScore > 21) and playerScore <= 21
      @get('playerHand').win()
      @get('dealerHand').lose()
      @set 'winner', @get('playerHand')
    else
      @get('playerHand').lose()
      @get('dealerHand').win()
      @set 'winner', @get('dealerHand')

  restart: ->
    @initialize();
    @set("winner", null)
