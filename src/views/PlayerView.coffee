class window.PlayerView extends Backbone.View

  initialize: ->
    @render()
    @model.on "change:chips", =>
      @render()

  render: ->
    @$el.text(@model.get "chips")