// Generated by CoffeeScript 1.6.2
(function() {
  define(["libs/backbone", "libs/underscore"], function() {
    var ProjectView;

    ProjectView = Backbone.View.extend({
      initialize: function() {
        _.bindAll(this);
        this.$el = $(this.el);
        this.model = new Backbone.Model(JSON.parse(this.$('.data').html()));
        this.render();
      },
      render: function() {
        var _this = this;

        _.each(this.model.get('images'), function(obj) {
          _this.$el.append(_this.template(obj));
        });
      },
      template: _.template("<div class=\"image\" style=\"width: <%= width %>px; height: <%= height %>px\">\n	<img src=\"<%= src %>\" style=\"width: <%= width %>px; height: <%= height %>px\" />\n</div>")
    });
    return ProjectView;
  });

}).call(this);
