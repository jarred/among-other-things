// Generated by CoffeeScript 1.3.3
(function() {

  define(["libs/backbone", "libs/underscore"], function() {
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
        console.log('render');
        _.each(this.model.get('images'), function(obj) {
          _this.$grid.append(_this.template(obj));
        });
      },
      template: _.template("<div class=\"cell <%= size %>\">\n	<div class=\"images\"><img src=\"<%= src %>\" class=\"<%= size %>\" /></div>\n</div>")
    });
    return ProjectView;
  });

}).call(this);
