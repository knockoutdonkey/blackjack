# TODO: Refactor this model to use an internal Game Model instead
# of containing the game logic directly.
class window.App extends Backbone.Model

  defaults:
    'winner': null
    'numPlayers': 3

  initialize: ->
    @set 'players', new Players()
    (@get('players').add(new Player()) for num in [0...@get 'numPlayers'])
    @set 'deck', deck = new Deck()
    @setUpGame()

  setUpGame: ->
    @set 'dealerHand', dealerHand = (@get 'deck').dealDealer()
    dealerHand.hide()
    @get('players').each (player) => 
      hand = (@get 'deck').dealPlayer()
      hand.hide()
      player.giveHand(hand)
      
    finishedCount = 0
    bestScore = 0
    @get('players').on "finished", (player)=>      
      finishedCount++

      playerScore = player.get('hand').score()
      if playerScore > bestScore and playerScore <= BJRules.MaxScore
        bestScore = playerScore

      if finishedCount is @get('numPlayers')
        @get('dealerHand').playOut bestScore
        @decideWinner()

    readyCount = 0
    @get('players').on "ready", =>
      readyCount++
      if readyCount is @get('numPlayers')
        @get('players').each (player) ->
          player.play()
        dealerHand.dealerReveal()


  decideWinner: ->
    console.log "decidedWinner"
    @get('players').each (player) =>
      playerScore = player.score()
      dealerScore = @get('dealerHand').score()
      if (playerScore > dealerScore or dealerScore > BJRules.MaxScore) and playerScore <= BJRules.MaxScore
        player.win()
        # @get('dealerHand').lose()

      else if playerScore is dealerScore
        player.tie()
        # @get('dealerHand').tie()

      else
        player.lose()
        # @get('dealerHand').win()

  restart: ->
    @get('players').each (player) -> player.lose()
    @setUpGame()
    @set("winner", null)
