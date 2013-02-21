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
					"libs/jquery.isotope.min"
					"libs/history.adapter.jquery"
					], () =>
						require [
							"views/project"
							"views/grid-item"
							"views/layout-experiment"
							], =>
								@init()
								return
		return

	init: ->
		@appModel = new Backbone.Model()
		@extendViews()
		@tick = setInterval () =>
			@onTick()
			return
		, 3000

		History.Adapter.bind window, 'statechange', @onStateChange if History.enabled

		$('#grid').isotope
			masonry:
				columnWidth: 150

		@animateGridItemsIn()
		return

	animateGridItemsIn: ->
		console.log 'animateGridItemsIn'
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

	onTick: ->
		@appModel.trigger 'tick'
		return

Main.go()