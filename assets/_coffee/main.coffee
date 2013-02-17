requirejs.config
	baseUrl: '/assets/js'

Main = 
	currentProject: 0

	init: ->
		Main.appModel = new Backbone.Model()
		Main.extendViews()
		Main.tick = setInterval () =>
			Main.onTick()
			return
		, 3000

		$('#grid').isotope
			masonry:
				columnWidth: 150
		return

	extendViews: ->
		_.each $('.extend-view'), (el) ->
			$el = $(el)
			viewName = "views/#{$el.data('view')}"
			view = require(viewName)
			new view
				el: el
				appModel: Main.appModel
			$el.removeClass 'extend-view'
			return
		return

	onTick: ->
		@appModel.trigger 'tick'
		return

# load libs...
require ["libs/jquery", "libs/underscore", "libs/greensock/TweenMax.min"], () ->
	# more libs...
	require ["libs/backbone", "libs/greensock/jquery.gsap.min", "libs/jquery.isotope.min"], () ->
		# views
		require ["views/project", "views/grid-item", "views/layout-experiment"], Main.init
		return
	return
