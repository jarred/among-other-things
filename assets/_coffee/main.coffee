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

		if History.enabled and window.location.pathname is '/'
			History.Adapter.bind window, 'statechange', () =>
				@onStateChange()
				return

		# $('#grid').isotope
		# 	masonry:
		# 		columnWidth: 150

		# @animateGridItemsIn()

		@animatePreloaderOut()
		return

	animatePreloaderOut: ->
		@$pre = $('#top .preloader')
		@$pre.trigger 'transition-out'
		h = $(window).height() - 130
		TweenMax.to $('#top'), .6, {bottom: h, ease: Quint.easeOut, delay: .7}
		_.delay @animateGridItemsIn, 900
		return

	animateGridItemsIn: ->
		_.each $('#grid .cell'), (el, index) =>
			$el = $(el)
			$el.css
				top: '40px'
			TweenMax.to $el, 0.23, {top:0, delay: index * 0.07, ease:Expo.easeOut, opacity: 1}
			return
		return

	animateGridItemsOut: ->
		_.each $('#grid .cell'), (el, index, items) =>
			$el = $(el)
			TweenMax.to $el, 0.23, 
				top: -40
				opacity: 0
				ease: Expo.easeOut
				# delay: index * 0.07
				delay: (items.length - index) * 0.07
				onComplete: () =>
					$el.trigger 'remove'
					# if index >= (items.length - 1)
					# 	@appModel.trigger 'transition-out-complete'
					@appModel.trigger 'transition-out-complete' if index is 0
					return
			return
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

	onStateChange: ->
		@state = History.getState()		
		switch @state.data.type
			when 'project'
				# project = new Backbone.Model state.data.model
				@project = new Backbone.Model @state.data.model
				@appModel.bind 'transition-out-complete', () =>
					@loadNext()
					return
				@animateGridItemsOut()

				preloaderView = require('views/preloader')
				view = new preloaderView()
				$('#top').append view.el
			else
				# back to the index?
				@appModel.bind 'transition-out-complete', () =>
					@showIndex()
					return
				@animateGridItemsOut()
		return

	loadNext: ->
		view = require("views/project")
		new view
			model: @project
			el: $('#grid')

		@animateGridItemsIn()
		$('#top .preloader').trigger 'transition-out'
		return

	showIndex: ->
		# $('#grid').remove()
		$('#grid').load "/ #grid"
		return

	onTick: ->
		@appModel.trigger 'tick'
		return

Main.go()