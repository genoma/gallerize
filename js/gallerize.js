(function($, window, document) {
  "use strict";
  var Plugin, defaults, pluginName;
  pluginName = "gallerize";
  defaults = {
    blocksPerRow: 5,
    mobileBlocksPerRow: 3,
    mobileBreackPoint: 700,
    margin: 0.5,
    height: "150px"
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
      var $images, $this, allImages, theBlockWidth, theBlockWidthWithMargins;
      $this = $(this.element);
      $images = $("img", $this);
      allImages = $images.get();
      theBlockWidth = (100 / this.breackPoint($this)) - this.settings.margin;
      theBlockWidthWithMargins = this.dinamicBreakpoint($this, this, allImages);
      $images.css("display", "none");
      this.breackPointFunction(allImages, theBlockWidth, this.settings.height, this.settings.margin, $this, this);
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
    breackPointFunction: function(allImages, theBlockWidth, height, margin, div, obj) {
      var i, images, len;
      for (i = 0, len = allImages.length; i < len; i++) {
        images = allImages[i];
        obj.giveBackground(images, theBlockWidth, height, margin, div);
      }
    },
    dinamicBreakpoint: function(div, obj, allImages) {
      return $(window).on("resize", function() {
        var theBlockWidth;
        $(div).html("");
        theBlockWidth = (100 / obj.breackPoint(div)) - obj.settings.margin;
        obj.breackPointFunction(allImages, theBlockWidth, obj.settings.height, obj.settings.margin, div, obj);
      });
    },
    giveBackground: function(src, width, height, margin, div) {
      var source;
      source = $(src).attr("src");
      return $(div).append('<div class="float-gallerize" style="background: url(' + source + '); height:' + height + '; width:' + width + '%; margin: ' + margin / 2 + '%;"></div>');
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
