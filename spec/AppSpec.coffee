assert = chai.assert

describe 'hand', ->
  app = null

  beforeEach ->
    app = new App()

  describe 'playOut', ->
    it 'should always have a value greater than 16', ->
      hand.playOut()
      console.log "#{hand.score()}"
      assert.strictEqual hand.score() > 16 , true
