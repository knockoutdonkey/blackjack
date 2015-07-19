class window.PlayerView extends Backbone.View

  template: _.template('<div class="player-hand-container"></div>
    <%= chips %><input class="betting-field" type="text"><button class="bet-button">Submit Bet</button>
      <button class="hit-button">Hit</button> <button class="stand-button">Stand</button> ')

  events:
    "click .bet-button": ->
      amount = @$(".betting-field").val()
      if not isNaN(amount)
        @model.bet(amount)
    'click .hit-button': -> 
      if not @model.get 'winner'
        @model.hit()
    'click .stand-button': -> @model.stand()

  initialize: ->
    @render()
    @model.on "change:chips change:phase", =>
      @render()

  render: ->
    @$el.children().detach()
    @$el.html @template @model.attributes
    @$('.player-hand-container').html new HandView(collection: @model.get 'hand').el
