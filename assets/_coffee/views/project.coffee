define ["libs/backbone", "libs/underscore"], () ->

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
			console.log 'render'
			_.each @model.get('images'), (obj) =>
				@$grid.append @template obj
				return
			return

		template: _.template """
		<div class="cell <%= size %>">
			<div class="images"><img src="<%= src %>" class="<%= size %>" /></div>
		</div>
		"""

	return ProjectView
