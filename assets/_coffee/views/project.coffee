define ["libs/backbone", "libs/underscore"], () ->

	ProjectView = Backbone.View.extend

		initialize: ->
			_.bindAll @
			@$el = $(@el)
			@model = new Backbone.Model JSON.parse @$('.data').html()
			@model.set 'images', _.shuffle @model.get('images')
			@render()
			return

		render: ->
			_.each @model.get('images'), (obj) =>
				@$el.append @template obj
				return
			return

		template: _.template """
		<div class="cell <%= size %>">
			<div class="images"><img src="<%= src %>" class="<%= size %>" /></div>
		</div>
		"""

	return ProjectView
