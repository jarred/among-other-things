define ["libs/backbone", "libs/underscore"], () ->

	LogoView = Backbone.View.extend

		className: 'box size11 logo'

		initialize: (@options) ->
			_.bindAll @
			@$el = $(@el)
			@render()
			return

		render: ->
			@$el.html "<p>(among*<br />^other~<br />#things)</p>"
			return

