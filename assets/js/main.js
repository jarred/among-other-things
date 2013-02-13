// Generated by CoffeeScript 1.3.3
(function() {
  var Main;

  requirejs.config({
    baseUrl: '/assets/js'
  });

  Main = {
    currentProject: 0,
    init: function() {
      var _this = this;
      Main.appModel = new Backbone.Model();
      Main.extendViews();
      Main.tick = setInterval(function() {
        Main.onTick();
      }, 3000);
      $('.grid-container').isotope({
        masonry: {
          columnWidth: 150
        }
      });
    },
    extendViews: function() {
      _.each($('.extend-view'), function(el) {
        var $el, view, viewName;
        $el = $(el);
        viewName = "views/" + ($el.data('view'));
        view = require(viewName);
        new view({
          el: el,
          appModel: Main.appModel
        });
        $el.removeClass('extend-view');
      });
    },
    onTick: function() {
      this.appModel.trigger('tick');
    }
  };

  require(["libs/jquery", "libs/underscore", "libs/greensock/TweenMax.min"], function() {
    require(["libs/backbone", "libs/greensock/jquery.gsap.min", "libs/jquery.isotope.min"], function() {
      require(["views/project", "views/grid-item", "views/layout-experiment"], Main.init);
    });
  });

}).call(this);
