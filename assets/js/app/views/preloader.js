// Generated by CoffeeScript 1.6.2
(function() {
  define(["backbone", "underscore"], function() {
    var PreloaderView;

    return PreloaderView = Backbone.View.extend({
      done: false,
      className: 'preloader',
      events: {
        'transition-out': 'transitionOut'
      },
      initialize: function(options) {
        this.options = options;
        _.bindAll(this);
        this.$el = $(this.el);
      },
      render: function() {
        this.$el.html(this.template({}));
      },
      template: _.template("<div class=\"lines\"></div>"),
      startTween: function() {},
      reset: function() {
        if (!this.done) {

        } else {

        }
      },
      transitionOut: function(e) {
        this.done = true;
      },
      transitionOutComplete: function() {
        this.$el.trigger('transition-out-complete');
        this.remove();
      }
    });
  });

}).call(this);
