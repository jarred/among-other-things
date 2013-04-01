// Generated by CoffeeScript 1.3.3
(function() {
  var Main;

  requirejs.config({
    baseUrl: '/assets/js'
  });

  Main = {
    go: function() {
      this.loadLibs();
    },
    loadLibs: function() {
      var _this = this;
      require(["libs/jquery", "libs/underscore", "libs/greensock/TweenMax.min", "libs/history"], function() {
        return require(["libs/backbone", "libs/greensock/jquery.gsap.min", "libs/jquery.isotope.min", "libs/history.adapter.jquery"], function() {
          return require(["views/project", "views/project-image", "views/grid-item", "views/layout-experiment", "views/preloader"], function() {
            _this.init();
          });
        });
      });
    },
    init: function() {
      var _this = this;
      this.appModel = new Backbone.Model();
      this.extendViews();
      this.tick = setInterval(function() {
        _this.onTick();
      }, 3000);
      if (History.enabled && window.location.pathname === '/') {
        History.Adapter.bind(window, 'statechange', function() {
          _this.onStateChange();
        });
      }
      this.animatePreloaderOut();
    },
    animatePreloaderOut: function() {
      var h,
        _this = this;
      this.$pre = $('#top .preloader');
      this.$pre.trigger('transition-out');
      h = $(window).height() - 130;
      TweenMax.to($('#top'), .6, {
        bottom: h,
        ease: Quint.easeOut,
        delay: .7,
        onComplete: function() {
          _this.hidePreloader();
        }
      });
      _.delay(this.animateGridItemsIn, 900);
    },
    hidePreloader: function() {
      console.log('hidePreloader');
      this.$pre.removeClass('animating');
      this.$pre.addClass('hide');
    },
    animateGridItemsIn: function() {
      var _this = this;
      _.each($('#grid .cell'), function(el, index) {
        var $el;
        $el = $(el);
        $el.css({
          top: '40px'
        });
        TweenMax.to($el, 0.23, {
          top: 0,
          delay: index * 0.07,
          ease: Expo.easeOut,
          opacity: 1
        });
      });
    },
    animateGridItemsOut: function() {
      var _this = this;
      _.each($('#grid .cell'), function(el, index, items) {
        var $el;
        $el = $(el);
        TweenMax.to($el, 0.23, {
          top: -40,
          opacity: 0,
          ease: Expo.easeOut,
          delay: (items.length - index) * 0.07,
          onComplete: function() {
            $el.trigger('remove');
            if (index === 0) {
              _this.appModel.trigger('transition-out-complete');
            }
          }
        });
      });
    },
    extendViews: function() {
      var _this = this;
      return _.each($('.extend-view'), function(el) {
        var $el, view, viewName;
        $el = $(el);
        viewName = "views/" + ($el.data('view'));
        view = require(viewName);
        new view({
          el: el,
          appModel: _this.appModel
        });
        $el.removeClass('extend-view');
      });
    },
    onStateChange: function() {
      var preloaderView, view,
        _this = this;
      this.state = History.getState();
      switch (this.state.data.type) {
        case 'project':
          this.project = new Backbone.Model(this.state.data.model);
          this.appModel.bind('transition-out-complete', function() {
            _this.loadNext();
          });
          this.animateGridItemsOut();
          preloaderView = require('views/preloader');
          view = new preloaderView();
          $('#top').append(view.el);
          break;
        default:
          this.appModel.bind('transition-out-complete', function() {
            _this.showIndex();
          });
          this.animateGridItemsOut();
      }
    },
    loadNext: function() {
      var view;
      view = require("views/project");
      new view({
        model: this.project,
        el: $('#grid')
      });
      this.animateGridItemsIn();
      $('#top .preloader').trigger('transition-out');
    },
    showIndex: function() {
      $('#grid').load("/ #grid");
    },
    onTick: function() {
      this.appModel.trigger('tick');
    }
  };

  Main.go();

}).call(this);
