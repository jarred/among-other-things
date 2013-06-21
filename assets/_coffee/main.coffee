requirejs.config
	baseUrl: '/assets/js/libs'
	paths:
		app: '../app'



Main =
	go: ->
		@loadLibs()
		return

	loadLibs: ->
		require [
			"jquery"
			"underscore"
			"greensock/TweenMax.min"
			# "history"
			], () =>
				require [
					"backbone", 
					"greensock/jquery.gsap.min"
					# "libs/history.adapter.jquery"
					], () =>
						require [
							# "views/project"
							# "views/project-image"
							# "views/grid-item"
							# "views/layout-experiment"
							"app/views/index"
							"app/views/intro"
							"app/views/logo"
							], =>
								@init()
								return
		return

	init: ->
		console.log 'hi?'
		return
		@appModel = new Backbone.Model()
		@extendViews()
		return

	extendViews: ->
		_.each $('.extend-view'), (el) =>
			$el = $(el)
			viewName = "app/views/#{$el.data('view')}"
			view = require(viewName)
			new view
				el: el
				appModel: @appModel
			$el.removeClass 'extend-view'
			return

Main.go()