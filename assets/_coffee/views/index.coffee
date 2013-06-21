define ["backbone", "underscore", "app/views/logo"], () ->

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

		projectsShown: 0
		
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
			<div class="box image-box <%= size %>">
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
			name = require("app/views/logo")
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
			@imagesAdded = @imagesLoaded = 0
			_.each project.images, (img) =>
				$el = @$(".#{img.size}:not(.has-image)")
				i = new Image()
				i.onload = @imageLoaded
				i.src = img.src
				$image = $ "<div class=\"image\"></div>"
				$image.append i
				$el.find('.internal').append $image
				$el.addClass 'has-image'
				@imagesAdded++
				return
			return

		imageLoaded: ->
			@imagesLoaded++
			if @imagesLoaded >= @imagesAdded
				if @projectsShown == 0
					@transitionProjectIn()
				else
					_.delay @transitionProjectIn, 3000
				@projectsShown++
			return

		transitionProjectIn: ->
			_.each @$('.image-box'), (el, index) =>
				$el = $(el)
				return if $el.hasClass 'logo' or $el.hasClass 'intro'
				internal = $el.find('.internal')
				newY = Number(internal.css('top').replace("px", "")) - $el.height()
				console.log newY
				TweenMax.to(internal, .3, {top: newY, delay: .1 * index})
				return
			console.log 'transitionProjectIn'
			return