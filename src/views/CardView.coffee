class window.CardView extends Backbone.View
  className: 'card'

  template: _.template '<img src="img/cards/<%= rankName %>-<%= suitName.toLowerCase() %>.png">'
  backTemplate: _.template '<img src="img/card-back.png">'
  initialize: -> @render()

  render: ->
    @$el.children().detach()
    if @model.get 'revealed' 
      @$el.html @template @model.attributes
    else 
      @$el.html @backTemplate @model.attributes
      
    @$el.addClass 'covered' unless @model.get 'revealed'

