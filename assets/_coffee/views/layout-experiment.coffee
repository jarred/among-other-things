define ["libs/backbone", "libs/underscore"], () ->

	LayoutView = Backbone.View.extend

		initialize: ->
			_.bindAll @
			@$el = $(@el)
			@total = 0
			# @int = setInterval @addCell, 1
			@model = new Backbone.Model JSON.parse @$('.data').html()
			@model.set 'images', _.shuffle @model.get('images')
			_.each @model.get('images'), @addCell
			# console.log @model.toJSON()
			@makeGrid()
			return

		template: _.template """
		<div class="cell">
			<div class="image" style="background-image:url('/assets/img/lookwork/<%= arguments[0] %>');"></div>
		</div>
		"""

		sizes: [
			"square-1col"
			"square-2col"
			"square-3col"
			"portrait-2col"
			# "portrait-3col"
			# "landscape-2col"
			"landscape-3col"
			# "landscape-4col"
		]

		addCell: (img) ->
			cell = $(@template(img))
			size = @sizes[Math.floor(Math.random() * @sizes.length)]
			console.log size
			cell.addClass size
			@$el.append cell
			@columnWidth = 130
			@marginWidth = 20
			return

		makeGrid: ->
			$('#grid').isotope
				masonry:
					columnWidth: @columnWidth + @marginWidth
			return

	return LayoutView
