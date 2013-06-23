// Generated by CoffeeScript 1.6.2
(function() {
  var _this = this;

  requirejs.config({
    baseUrl: '/assets/js/libs',
    paths: {
      app: '../app',
      indexView: '../app/views/index',
      logoView: '../app/views/logo',
      introView: '../app/views/intro'
    },
    shim: {
      backbone: {
        deps: ['jquery', 'underscore'],
        exports: 'Backbone'
      },
      indexView: {
        deps: ['backbone']
      },
      'jquery.shuffle': {
        deps: ['jquery']
      },
      'jquery.isotope.min': {
        deps: ['jquery']
      }
    }
  });

  require(['jquery', 'underscore', 'backbone', 'greensock/TweenMax.min', 'indexView', 'logoView', 'jquery.shuffle', 'jquery.isotope.min'], function($, _, Backbone, TweenMax, IndexView, LogoView) {
    var App;

    App = {
      go: function() {
        var index;

        return index = new IndexView({
          el: $('body')
        });
      }
    };
    return App.go();
  });

}).call(this);
