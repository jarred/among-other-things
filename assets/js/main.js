// Generated by CoffeeScript 1.3.3
(function() {
  var Main;

  requirejs.config({
    baseUrl: '/assets/js'
  });

  Main = {
    currentProject: 0,
    init: function() {
      var $first;
      Main.extendViews();
      $first = $($('.project')[0]);
      Main.totalProjects = $('.project').length;
      console.log(this);
      Main.showProject(0);
    },
    extendViews: function() {
      _.each($('.extend-view'), function(el) {
        var $el, view, viewName;
        $el = $(el);
        viewName = $el.data('view');
        view = require("views/project");
        new view({
          el: el
        });
        $el.removeClass('extend-view');
      });
    },
    nextProject: function() {
      Main.currentProject++;
      if (Main.currentProject < Main.totalProjects) {
        Main.showProject(Main.currentProject);
      } else {
        Main.showProject(0);
      }
    },
    showProject: function(n) {
      var $el,
        _this = this;
      console.log('showProject', n);
      $('.project.visible').removeClass('visible');
      $el = $($('.project')[n]);
      $el.bind('completed', function() {
        Main.nextProject();
      });
      $el.trigger('ready');
      Main.currentProject = n;
    }
  };

  require(["libs/jquery", "libs/underscore"], function() {
    require(["libs/backbone"], function() {
      require(["views/project"], Main.init);
    });
  });

}).call(this);
