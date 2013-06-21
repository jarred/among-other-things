requirejs.config
	baseUrl: '/assets/js/libs'
	paths:
		app: '../app'
		indexView: '../app/views/index'

	shim:
		backbone:
			deps: ['jquery', 'underscore']
			exports: 'Backbone'
		indexView:
			deps: ['backbone']

# lets go...

require ['jquery', 'underscore', 'backbone', 'indexView', 'greensock/TweenMax.min'], ($, _, Backbone, IndexView, TweenMax) =>

	App =
		go: ->
			index = new IndexView
				el: $('body')

	App.go()