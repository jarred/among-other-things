define ["libs/backbone", "libs/underscore"], () ->

	PreloaderView = Backbone.View.extend

		done: false
		className: 'preloader'

		events:
			'transition-out': 'transitionOut'

		initialize: (@options) ->
			_.bindAll @
			@$el = $(@el)
			@render()
			@$internal = @$('.internal')
			@startTween()
			return

		render: ->
			@$el.html @template {}
			return

		template: _.template """
		<div class="internal"></div>
		"""

		startTween: ->
			TweenMax.to @$internal, .4, {left: 0, onComplete: @reset, ease: Linear.easeNone}
			return

		reset: ->
			if !@done
				@$internal.css
					left: '-300px'
				@startTween()
			else
				@$internal.css
					left: '-300px'
				TweenMax.to @$internal, .4, {left: 0, ease: Linear.easeNone, opacity: 0, onComplete: @transitionOutComplete}
			return

		transitionOut: (e) ->
			@done = true
			return

		transitionOutComplete: ->
			@$el.trigger 'transition-out-complete'
			@remove()
			return