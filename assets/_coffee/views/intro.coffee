define ["libs/backbone", "libs/underscore"], () ->

	IntroView = Backbone.View.extend

		className: 'box size21 intro'

		initialize: (@options) ->
			_.bindAll @
			@$el = $(@el)
			@render()
			return

		render: ->
			@$el.html "<p>The portfolio of Jarred Bishop <span class=\"mdash\">&mdash;</span><br /><span class=\"loading\">is loading...</span></p>"
			return

