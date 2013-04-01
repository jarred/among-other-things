define ["libs/backbone", "libs/underscore"], () ->

	ProjectImage = Backbone.View.extend

		initialize: (@options) ->
			_.bindAll @
			@$el = $(@el)
			console.log 'ProjectImage', @model.toJSON()
			@render()
			return

		template: _.template """
			<div class="internal">
				<div class="block">
					<div class="preloader animating">
						<div class="lines"></div>
					</div>
				</div>
			</div>
		"""

		render: ->
			@$el.html @template @model.toJSON()

			@img = new Image()
			@img.onload = @transitionIn
			@img.src = @model.get('src')
			@$('.internal').append @img
			return

		transitionIn: ->
			console.log 'transitionIn'
			TweenMax.to @$('.internal'), .3, {top: 0 - @$el.height()}
			return

	return ProjectImage
