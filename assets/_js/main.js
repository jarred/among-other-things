var $             = require('jquery');
global.jQuery     = $;
var _             = require('underscore');
var Backbone      = require('backbone');
Backbone.$        = $;
var TweenMax      = require('gsap');

var AOT = {};
AOT.App = {
  init: function(){
    TweenMax.to($('.js-site-preloader'), .7, {
      top: '100%',
      ease: Quint.easeInOut,
      delay: .6
    });
  }
}

AOT.App.init();
module.exports = AOT;
