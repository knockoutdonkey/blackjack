window.appModel = new App()
window.appView = new AppView(model: appModel)
window.appViewEl = appView.$el.appendTo 'body'

