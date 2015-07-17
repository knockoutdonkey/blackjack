class window.AppView extends Backbone.View
  template: _.template '
    <button class="hit-button">Hit</button> <button class="stand-button">Stand</button> <button class="restart-button">Restart</button>
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
  '

  events:
    'click .hit-button': -> 
      if not @model.get 'winner'
        @model.get('playerHand').hit()
    'click .stand-button': -> @model.get('playerHand').stand()
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
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el
    @$('.winner').html 

