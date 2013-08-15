define ["logoView", 'introView'], (LogoView, IntroView) ->

	IndexView = Backbone.View.extend

		projectsShown: 0
		
		initialize: (@options) ->
			_.bindAll @
			@model = @getData()
			sizeCount = {}

			_.each @model.get('projects'), (project) =>
				_.each project.images, (image) =>
					if sizeCount[image.size]?
						sizeCount[image.size].count++
					else
						sizeCount[image.size] =
							count: 0

			@intro = new IntroView
				el: @$('.intro')
			@showProject 0
			return

		getData: ->
			model = new Backbone.Model
				projects: []
			_.each @$('.project'), (el) =>
				$el = $(el)
				projectData = JSON.parse $el.find('.data').html()
				model.get('projects').push projectData
				
			# model.set 'projects', _.shuffle(model.get('projects'))
			return model

		randomiseLayout: ->
			screenW = $(window).width()
			screenH = $(window).height()
			_.each $('.box'), (el) =>
				$el = $(el)
				x = Math.round Math.random() * (screenW - $el.width())
				y = Math.round Math.random() * (screenH - $el.height())
				$el.css
					left: "#{x}px"
					top: "#{y}px"

		showProject: (num) ->
			@currentProject = num
			@project = @model.get('projects')[num]
			@project.images = _.shuffle @project.images
			@$('.image-box').addClass 'empty'
			@imageCount = 0
			@imagesLoaded = 0
			
			_.each @project.images, (image) =>
				$box = $(".#{image.size}")
				return if !$box.hasClass 'empty'
				@imageCount++
				img = new Image()
				img.src = image.src
				img.onload = @imageLoaded
				$container = $ "<div class=\"image slide\"></div>"
				$container.append img
				$box.find('.internal').append $container
				$box.removeClass 'empty'
			
			_.each @$('.box.empty'), (el) =>
				$el = $(el)
				$el.find('.internal').append "<div class=\"blank slide\"></div>"

		imageLoaded: ->
			@imagesLoaded++
			if @imagesLoaded >= @imageCount
				@animateProjectIn()
				@animateProjectInfoOut()

		animateProjectInfoOut: ->
			TweenMax.to @$('.info'), .3, 
				opacity: 0
				ease: Quint.easeIn
				onComplete: @animateProjectInfoIn

		animateProjectInfoIn: ->
			url = @$(".project[data-index=#{@currentProject}]").data('url')
			title = @$(".project[data-index=#{@currentProject}] .title").text()
			content = @$(".project[data-index=#{@currentProject}] .excerpt").html()
			if url is "none"
				@$('.info h2').text title
			else
				@$('.info h2').html "<a href=\"#{url}\">#{title}</a>"
			@$('.info .content').html content

			TweenMax.to @$('.info'), .3, 
				ease: Quint.easeOut
				opacity: 1
				delay: .2

		animateProjectIn: ->
			@intro.trigger 'animate-in', @project
			_.each $('.image-box'), (el, index) =>
				$el = $(el)
				h = $el.height()
				tween =
					top: 0 - h
					ease: Quint.easeOut
					delay: .3 + index * .1
				if index + 1 >= $('.image-box').length
					tween.onComplete = @projectAnimatedIn
				TweenMax.to $el.find('.internal'), .3, tween

		projectAnimatedIn: ->
			_.each @$('.box'), (el) =>
				$el = $(el)
				$el.find('.slide:first').remove()
				$el.find('.internal').css
					top: '0px'
			_.delay @nextProject, 7000

		nextProject: ->
			if @currentProject < @model.get('projects').length - 1
				@showProject @currentProject + 1
			else
				@showProject 0