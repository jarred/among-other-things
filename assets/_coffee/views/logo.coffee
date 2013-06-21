define ["backbone", "underscore"], () ->

	LogoView = Backbone.View.extend

		initialize: (@options) ->
			_.bindAll @