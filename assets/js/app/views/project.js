// Generated by CoffeeScript 1.6.2
(function() {
  define(["backbone", "underscore"], function() {
    var ProjectView;

    ProjectView = Backbone.View.extend({
      initialize: function(options) {
        this.options = options;
        _.bindAll(this);
        this.$el = $(this.el);
        if (this.options.model === void 0) {
          this.model = new Backbone.Model(JSON.parse(this.$('.data').html()));
        }
        this.model.set('images', _.shuffle(this.model.get('images')));
        this.$grid = $('#grid');
        this.render();
      },
      render: function() {
        var _this = this;

        _.each(this.model.get('images'), function(obj) {
          var cell, view;

          view = require("views/project-image");
          cell = new view({
            model: new Backbone.Model(obj),
            attributes: {
              "class": "cell " + obj.size
            }
          });
          _this.$grid.append(cell.el);
        });
      }
    });
    return ProjectView;
  });

}).call(this);
