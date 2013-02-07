define ["libs/backbone", "libs/underscore"], () ->

	ProjectView = Backbone.View.extend

		currentSlide: 0

		events:
			'ready': 'ready'

		initialize: ->
			_.bindAll @
			@$el = $(@el)
			@totalSlides = @$('.slide').length
			@showSlide(0)
			return

		ready: ->
			@$el.addClass 'visible'
			@int = setInterval @tick, 600
			return

		showSlide: (n) ->
			@$('.slide.visible').removeClass 'visible'
			el = @$('.slide')[n]
			$el = $(el)
			$el.addClass 'visible'
			@currentSlide = n
			return

		tick: ->
			@currentSlide++
			@showSlide @currentSlide
			if @currentSlide == @totalSlides
				clearInterval @tick
				@$el.trigger 'completed'
			return

	return ProjectView
