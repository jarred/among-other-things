requirejs.config
	baseUrl: '/assets/js'

Main = 
	currentProject: 0

	init: ->
		Main.extendViews()

		$first = $($('.project')[0])
		Main.totalProjects = $('.project').length
		console.log @
		Main.showProject 0
		return

	extendViews: ->
		_.each $('.extend-view'), (el) ->
			$el = $(el)
			viewName = $el.data 'view'
			view = require("views/project")
			new view
				el: el
			$el.removeClass 'extend-view'
			return
		return

	nextProject: ->
		Main.currentProject++
		if Main.currentProject < Main.totalProjects
			Main.showProject Main.currentProject
		else
			Main.showProject 0
		return

	showProject: (n) ->
		console.log 'showProject', n
		$('.project.visible').removeClass 'visible'
		$el = $($('.project')[n])
		$el.bind 'completed', () =>
			Main.nextProject()
			return
		$el.trigger 'ready'
		Main.currentProject = n
		return

# load libs...
require ["libs/jquery", "libs/underscore"], () ->
	# more libs...
	require ["libs/backbone"], () ->
		# views
		require ["views/project"], Main.init
		return
	return
