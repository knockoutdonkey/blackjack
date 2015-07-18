class window.AppView extends Backbone.View
  template: _.template '
    <button class="hit-button">Hit</button> <button class="stand-button">Stand</button> <button class="restart-button">Restart</button>
    <div class="player-container"></div>
    <div class="dealer-hand-container"></div>
  '

  events:
    'click .hit-button': -> 
      if not @model.get 'winner'
        @model.get('player').hit()
    'click .stand-button': -> @model.get('player').stand()
    'click .restart-button': -> 
      @model.restart()
      @render()

  initialize: ->
    @render()

    @model.on 'change:winner', =>
      @render()

  render: ->
    @$el.children().detach()
    @$el.html @template()
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el
    @$('.player-container').html new PlayerView(model: @model.get 'player').el
    @$('.winner').html 

