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
							"views/project"
							"views/project-image"
							"views/grid-item"
							"views/layout-experiment"
							"views/index"
							"views/preloader"
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

		@animatePreloaderOut()
		return

	animatePreloaderOut: ->
		@$pre = $('#top .preloader')
		@$pre.trigger 'transition-out'
		h = $(window).height() - 130
		TweenMax.to $('#top'), .6, {bottom: h, ease: Quint.easeOut, delay: .7, onComplete: () =>
			@hidePreloader()
			return}
		# _.delay @animateGridItemsIn, 900
		return

	hidePreloader: ->
		console.log 'hidePreloader'
		@$pre.removeClass 'animating'
		@$pre.addClass 'hide'
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