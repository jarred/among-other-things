// Generated by CoffeeScript 1.3.3
(function() {

  define(["libs/backbone", "libs/underscore"], function() {
    var IndexView;
    return IndexView = Backbone.View.extend({
      sizes: ["size22", "size32", "size32", "size23", "size34", "size34", "size43", "logo"],
      initialize: function(options) {
        this.options = options;
        _.bindAll(this);
        this.$el = $(this.el);
        this.sizes = _.shuffle(this.sizes);
        _.each(this.sizes, this.addCell);
        this.model = this.getData();
        $("#grid").nested({
          animate: false,
          minWidth: 130,
          gutter: 20,
          selector: '.box',
          resizeToFitOptions: {
            resizeAny: false
          }
        });
      },
      cellTemplate: _.template("<div class=\"box <%= size %>\">\n	<div class=\"internal\">\n		<div class=\"preloader animating\">\n			<div class=\"lines\"></div>\n		</div>\n	</div>\n</div>"),
      addCell: function(size) {
        var data;
        if (size === 'bio') {
          this.addBio();
          return;
        }
        if (size === 'logo') {
          this.addLogo();
          return;
        }
        data = {
          size: size
        };
        $('#grid').append(this.cellTemplate(data));
      },
      addBio: function() {
        var name, view;
        name = require("views/intro");
        view = new name({
          appModel: this.model
        });
        $('#grid').append(view.el);
      },
      addLogo: function() {
        var name, view;
        name = require("views/logo");
        view = new name({
          appModel: this.model
        });
        $('#grid').append(view.el);
      },
      getData: function() {
        var model,
          _this = this;
        model = new Backbone.Model({
          projects: []
        });
        _.each(this.$('.project'), function(el) {
          var $el, projectData;
          $el = $(el);
          projectData = JSON.parse($el.find('.data').html());
          model.get('projects').push(projectData);
        });
        return model;
      },
      preloadProject: function(n) {
        var project,
          _this = this;
        project = this.model.get('projects')[n];
        _.each(project.images, function(img) {
          var $el;
          console.log(img.src);
          $el = _this.$("." + img.size + ":not(.has-image)");
          $el.find('.internal').append("<div class=\"image\"><img src=\"" + img.src + "\" /></div>");
          $el.addClass('has-image');
        });
      }
    });
  });

}).call(this);
