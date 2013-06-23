requirejs.config
	baseUrl: '/assets/js/libs'
	paths:
		app: '../app'
		indexView: '../app/views/index'
		logoView: '../app/views/logo'
		introView: '../app/views/intro'

	shim:
		backbone:
			deps: ['jquery', 'underscore']
			exports: 'Backbone'
		indexView:
			deps: ['backbone']
		'jquery.shuffle':
			deps: ['jquery']
		'jquery.isotope.min':
			deps: ['jquery']

# lets go...

require ['jquery', 'underscore', 'backbone', 'greensock/TweenMax.min', 'indexView', 'logoView', 'jquery.shuffle', 'jquery.isotope.min'], ($, _, Backbone, TweenMax, IndexView, LogoView) =>

	App =
		go: ->
			index = new IndexView
				el: $('body')

	App.go()