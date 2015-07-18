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
      assert.strictEqual hand.score() > 16 , true

  describe 'test Black Jack detection', ->
    ace = new Card
        rank: 1
        suit: 0
    faceCard = new Card
        rank: 11
        suit: 0
    sevenCard = new Card
        rank: 7
        suit: 1

    it 'detects a black jack', ->
      bjHand = new Hand([ace,faceCard])
      assert.strictEqual bjHand.hasBlackJack() , true

    it 'detects non-black jack', ->
      nonHand = new Hand([ace, sevenCard])
      assert.strictEqual nonHand.hasBlackJack() , false