define ["backbone", "underscore"], () ->

	ProjectView = Backbone.View.extend

		initialize: (@options) ->
			_.bindAll @
			@$el = $(@el)
			if @options.model is undefined
				@model = new Backbone.Model JSON.parse @$('.data').html()
			@model.set 'images', _.shuffle @model.get('images')
			@$grid = $('#grid')
			@render()
			return

		render: ->
			_.each @model.get('images'), (obj) =>
				view = require("views/project-image")
				cell = new view
					model: new Backbone.Model obj
					attributes:
						class: "cell #{obj.size}"
				@$grid.append cell.el
				return
			return

	return ProjectView
