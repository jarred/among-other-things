define ["libs/backbone", "libs/underscore"], () ->

	ProjectView = Backbone.View.extend

		initialize: ->
			_.bindAll @
			@$el = $(@el)
			@model = new Backbone.Model JSON.parse @$('.data').html()
			@render()
			return

		render: ->
			_.each @model.get('images'), (obj) =>
				@$el.append @template obj
				return
			return

		template: _.template """
		<div class="image" style="width: <%= width %>px; height: <%= height %>px">
			<img src="<%= src %>" style="width: <%= width %>px; height: <%= height %>px" />
		</div>
		"""

	return ProjectView
