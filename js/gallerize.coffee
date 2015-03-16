(($, window, document) ->

  "use strict"

  # Create the defaults once
  pluginName = "gallerize"
  defaults =
    blocksPerRow: 5
    mobileBlocksPerRow: 3
    mobileBreackPoint: 700
    height: "100px"

  # The actual plugin constructor
  Plugin = (element, options) ->
    @element = element
    @settings = $.extend({}, defaults, options)
    @_defaults = defaults
    @_name = pluginName
    @init()
    return

  # Avoid Plugin.prototype conflicts
  $.extend Plugin.prototype,
    init: ->
      $this = $(this.element)
      $images = $("img", $this)

      allImages = $images.get()

      theBlockWidth = 100 / this.breackPoint($this)

      this.dinamicBreakpoint($this, this, allImages)

      $images.css "display", "none"

      this.giveBackground(images, theBlockWidth, this.settings.height, $this) for images in allImages


      return

    getWidth: (div) ->
      return $(div).width()

    breackPoint: (div) ->
      theWidth = this.getWidth(div)
      if theWidth > this.settings.mobileBreackPoint
        return this.settings.blocksPerRow
      else
        return this.settings.mobileBlocksPerRow

    dinamicBreakpoint: (div, th, img) ->
      $(window).on "resize", ->
        $(div).html("")
        theBlockWidth = 100 / th.breackPoint(div)
        th.giveBackground(images, theBlockWidth, th.settings.height, div) for images in img
        return

    giveBackground: (src, width, height, div) ->
      source = $(src).attr("src")
      $(div).append('<div class="float-gallerize"
        style="background: url(' + source + ');
        height:' + height + '; width:' + width + '%"></div>')



  # A really lightweight plugin wrapper around the constructor,
  # preventing against multiple instantiations
  $.fn[pluginName] = (options) ->
    @each ->
      if !$.data(this, "plugin_" + pluginName)
        $.data this, "plugin_" + pluginName, new Plugin(this, options)
      return

  return
) jQuery, window, document
