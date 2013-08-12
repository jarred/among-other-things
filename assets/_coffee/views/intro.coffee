define ["backbone", "underscore"], () ->

	IntroView = Backbone.View.extend

		initialize: (@options) ->
			_.bindAll @
			@on 'animate-in', @animateIn
			@$el.addClass 'ready'

		animateIn: (project) ->
			# console.log 'logo.animateIn', project.noun
			# @$('.phrase').html project.noun
			TweenMax.to @$('.phrase'), .3, 
				opacity: 0
				onComplete: () =>
					@$('.phrase').html project.noun
					@$el.removeClass 'loading'
					TweenMax.to @$('.phrase'), .3, 
						opacity: 1 