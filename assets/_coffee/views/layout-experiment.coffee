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
			<div class="image" style="background-image: url('/assets/img/lookwork/<%= arguments[0] %>');">

			</div>
		</div>
		"""

		addCell: (img) ->
			cell = $(@template(img))
			span = Math.ceil(Math.random() * 3)
			@columnWidth = 130
			@marginWidth = 20
			width = ((@columnWidth + @marginWidth) * span) - @marginWidth
			height = width * 0.67

			# height = 150 if width == 150
			if Math.random() < 0.3
				height = width * 1.5
			else if Math.random() < 0.6
				height = width
			if width == 130
				height = 130
			
			height = width
			cell.css
				width: "#{width}px"
				height: "#{height}px"

			if Math.random() < 0.333333
				cell.addClass 'left'
			else if Math.random() < 0.66666
				cell.addClass 'center'
			else
				cell.addClass 'right'

			if Math.random() < 0.5
				cell.addClass 'bottom'
			@$el.append cell
			return

		makeGrid: ->
			$('#grid').isotope
				masonry:
					columnWidth: @columnWidth + @marginWidth
			return

	return LayoutView
