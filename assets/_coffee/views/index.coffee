define ["libs/backbone", "libs/underscore"], () ->

	IndexView = Backbone.View.extend

		sizes: [

			"size22"
			"size32"
			"size32"
			"size23"
			"size34"
			"size34"
			"size43"
			"logo"
		]
		
		initialize: (@options) ->
			_.bindAll @
			@$el = $(@el)
			@sizes = _.shuffle @sizes
			_.each @sizes, @addCell
			@model = @getData()

			$("#grid").nested
				animate: false
				minWidth: 130
				gutter: 20
				selector: '.box'
				resizeToFitOptions: 
				    resizeAny: false

			# @preloadProject(0)
			return

		cellTemplate: _.template """
		<div class="box <%= size %>">
			<div class="internal">
				<div class="preloader animating">
					<div class="lines"></div>
				</div>
			</div>
		</div>
		"""

		addCell: (size) ->
			if size is 'bio'
				@addBio()
				return
			if size is 'logo'
				@addLogo()
				return
			data =
				size: size
			$('#grid').append @cellTemplate data
			return

		addBio: ->
			name = require("views/intro")
			view = new name
				appModel: @model
			$('#grid').append view.el
			return

		addLogo: ->
			name = require("views/logo")
			view = new name
				appModel: @model
			$('#grid').append view.el
			return

		getData: ->
			model = new Backbone.Model
				projects: []
			_.each @$('.project'), (el) =>
				$el = $(el)
				projectData = JSON.parse $el.find('.data').html()
				model.get('projects').push projectData
				return
			return model

		preloadProject: (n) ->
			project = @model.get('projects')[n]
			_.each project.images, (img) =>
				console.log img.src
				$el = @$(".#{img.size}:not(.has-image)")
				$el.find('.internal').append "<div class=\"image\"><img src=\"#{img.src}\" /></div>"
				$el.addClass 'has-image'
				return


			return