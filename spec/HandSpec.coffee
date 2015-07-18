assert = chai.assert

describe 'hand', ->
  deck = null
  hand = null

  beforeEach ->
    deck = new Deck()
    hand = deck.dealDealer()

  describe 'playOut', ->
    it 'should always have a value greater than 16', ->
      hand.playOut()
      console.log "#{hand.score()}"
      assert.strictEqual hand.score() > 16 , true
