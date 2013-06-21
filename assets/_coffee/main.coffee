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
							"app/views/project"
							"app/views/project-image"
							"app/views/grid-item"
							"app/views/layout-experiment"
							"app/views/index"
							"app/views/preloader"
							], =>
								@init()
								return
		return

	init: ->
		console.log 'hi?'
		return
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
			viewName = "app/views/#{$el.data('view')}"
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