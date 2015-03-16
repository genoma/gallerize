(function($, window, document) {
  "use strict";
  var Plugin, defaults, pluginName;
  pluginName = "gallerize";
  defaults = {
    blocksPerRow: 5,
    mobileBlocksPerRow: 3,
    mobileBreackPoint: 700,
    height: "100px"
  };
  Plugin = function(element, options) {
    this.element = element;
    this.settings = $.extend({}, defaults, options);
    this._defaults = defaults;
    this._name = pluginName;
    this.init();
  };
  $.extend(Plugin.prototype, {
    init: function() {
      var $images, $this, allImages, i, images, len, theBlockWidth;
      $this = $(this.element);
      $images = $("img", $this);
      allImages = $images.get();
      theBlockWidth = 100 / this.breackPoint($this);
      this.dinamicBreakpoint($this, this, allImages);
      $images.css("display", "none");
      for (i = 0, len = allImages.length; i < len; i++) {
        images = allImages[i];
        this.giveBackground(images, theBlockWidth, this.settings.height, $this);
      }
    },
    getWidth: function(div) {
      return $(div).width();
    },
    breackPoint: function(div) {
      var theWidth;
      theWidth = this.getWidth(div);
      if (theWidth > this.settings.mobileBreackPoint) {
        return this.settings.blocksPerRow;
      } else {
        return this.settings.mobileBlocksPerRow;
      }
    },
    dinamicBreakpoint: function(div, th, img) {
      return $(window).on("resize", function() {
        var i, images, len, theBlockWidth;
        $(div).html("");
        theBlockWidth = 100 / th.breackPoint(div);
        for (i = 0, len = img.length; i < len; i++) {
          images = img[i];
          th.giveBackground(images, theBlockWidth, th.settings.height, div);
        }
      });
    },
    giveBackground: function(src, width, height, div) {
      var source;
      source = $(src).attr("src");
      return $(div).append('<div class="float-gallerize" style="background: url(' + source + '); height:' + height + '; width:' + width + '%"></div>');
    }
  });
  $.fn[pluginName] = function(options) {
    return this.each(function() {
      if (!$.data(this, "plugin_" + pluginName)) {
        $.data(this, "plugin_" + pluginName, new Plugin(this, options));
      }
    });
  };
})(jQuery, window, document);

//# sourceMappingURL=gallerize.js.map
