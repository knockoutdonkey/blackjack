class window.PlayerView extends Backbone.View

  template: _.template('<%= chips %><input class="betting-field" type="text"><button class="bet-button">Submit Bet</button>')

  events:
    "click .bet-button": ->
      amount = $(".betting-field").val()
      if not isNaN(amount)
        @model.bet(amount);

  initialize: ->
    @render()
    @model.on "change:chips", =>
      @render()

  render: ->
    @$el.html @template @model.attributes