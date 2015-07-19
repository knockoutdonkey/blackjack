class window.AppView extends Backbone.View
  template: _.template '
    <button class="restart-button">Restart</button>
    <div class="dealer-hand-container"></div>
    <div class="players-container"></div>
  '

  events:
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
    @model.get('players').each (player) => 
      @$('.players-container').append(new PlayerView(model: player).el)
    # @$('.players-container').html new PlayerView(model: @model.get 'player').el
    @$('.winner').html 

