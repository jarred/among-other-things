define ["libs/backbone", "libs/underscore"], () ->

	ProjectView = Backbone.View.extend
		
		currentImage: -1

		initialize: (@options) ->
			_.bindAll @
			@$el = $(@el)
			@index = Number @$el.attr('data-index')
			@model = new Backbone.Model JSON.parse @$('.data').html()
			features = _.reject @model.get('images'), (img) =>
				if img.size == @model.get('size')
					return false
				else
					return true
			@model.set 'features', _.shuffle(features)
			@render()
			return

		render: ->
			_.each @model.get('features'), (obj, index) =>
				img = new Image()
				img.onload = @firstImageLoaded if index == 0
				# img.onload = @lastImageLoaded if index == @model.get('features').length - 1
				img.src = obj.src
				$img = $(img)
				$img.addClass obj.size
				@$('.images .internal').append $img
				return 
			return

		firstImageLoaded: ->
			# @showImage 0
			@options.appModel.bind 'tick', @next
			return

		lastImageLoaded: ->
			$el = $(@$('.images img')[@model.get('features').length - 1])
			img = new Image()
			img.src = $el.attr('src')
			$img = $(img)
			$img.css
				width: $el.css('width')
				height: $el.css('height')
			@$('.preloader').replaceWith $img
			return

		showImage: (num) ->
			@currentImage = num			
			y = 0 - (@$('.images').height() * (num + 1))
			TweenMax.to(@$('.images .internal'), 0.4, {top:y, delay: @index * 0.16, ease:Expo.easeOut})
			return

		next: ->
			if @currentImage + 1 < @model.get('features').length
				@showImage @currentImage + 1
			else
				@showImage 0
			return
