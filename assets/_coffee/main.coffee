requirejs.config
	baseUrl: '/assets/js'

Main =
	go: ->
		@loadLibs()
		return

	loadLibs: ->
		require [
			"libs/jquery"
			"libs/underscore"
			"libs/greensock/TweenMax.min"
			"libs/history"
			], () =>
				require [
					"libs/backbone", 
					"libs/greensock/jquery.gsap.min"
					# "libs/jquery.isotope.min"
					"libs/jquery.nested.1.0.1"
					# "libs/history.adapter.jquery"
					], () =>
						require [
							# "views/project"
							# "views/project-image"
							# "views/grid-item"
							# "views/layout-experiment"
							"views/index"
							"views/intro"
							"views/logo"
							], =>
								@init()
								return
		return

	init: ->
		@appModel = new Backbone.Model()
		@extendViews()
		return

	extendViews: ->
		_.each $('.extend-view'), (el) =>
			$el = $(el)
			viewName = "views/#{$el.data('view')}"
			view = require(viewName)
			new view
				el: el
				appModel: @appModel
			$el.removeClass 'extend-view'
			return

Main.go()