define ["libs/backbone", "libs/underscore"], () ->

	IndexView = Backbone.View.extend

		sizes: [
			"size11"
			"size11 blank"
			"size11 blank"
			"size11 blank"
			"size11 blank"
			"size11 blank"
			"size11"
			"size22"
			"size32"
			"size32"
			"size23"
			"size34"
			"size34"
			"size43"
			"size11 logo"
			"size21 bio"
		]
		
		initialize: (@options) ->
			_.bindAll @
			@$el = $(@el)
			@sizes = _.shuffle @sizes
			_.each @sizes, @addCell

			$("#grid").nested
				animate: false
				minWidth: 130
				gutter: 20
				selector: '.box'
				resizeToFitOptions: 
				    resizeAny: true
			return

		template: _.template """
		<div class="></div>
		"""

		addCell: (size) ->
			$box = $("<div class=\"box #{size}\"></div>")
			$('#grid').append $box
			return