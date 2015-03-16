(($, window, document) ->

  "use strict"

  # Create the defaults once
  pluginName = "gallerize"
  defaults =
    blocksPerRow: 5
    mobileBlocksPerRow: 3
    mobileBreackPoint: 700
    margin: 0.5
    height: "150px"

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

      theBlockWidth = (100 / this.breackPoint($this)) - this.settings.margin

      theBlockWidthWithMargins =

      this.dinamicBreakpoint($this, this, allImages)

      $images.css "display", "none"

      this.breackPointFunction allImages,
                               theBlockWidth,
                               this.settings.height,
                               this.settings.margin,
                               $this, this

      return

    getWidth: (div) ->
      return $(div).width()

    breackPoint: (div) ->
      theWidth = this.getWidth(div)
      if theWidth > this.settings.mobileBreackPoint
        return this.settings.blocksPerRow
      else
        return this.settings.mobileBlocksPerRow

    breackPointFunction: (allImages, theBlockWidth, height, margin, div, obj) ->
      obj.giveBackground(images, theBlockWidth, height, margin, div) for images in allImages
      return


    dinamicBreakpoint: (div, obj, allImages) ->
      $(window).on "resize", ->
        $(div).html("")
        theBlockWidth = (100 / obj.breackPoint(div)) - obj.settings.margin
        obj.breackPointFunction allImages,
                                 theBlockWidth,
                                 obj.settings.height,
                                 obj.settings.margin,
                                 div, obj
        return

    giveBackground: (src, width, height, margin, div) ->
      source = $(src).attr("src")
      $(div).append('<div class="float-gallerize"
        style="background: url(' + source + ');
        height:' + height + '; width:' + width + '%;
        margin: ' + margin / 2 + '%;"></div>')



  # A really lightweight plugin wrapper around the constructor,
  # preventing against multiple instantiations
  $.fn[pluginName] = (options) ->
    @each ->
      if !$.data(this, "plugin_" + pluginName)
        $.data this, "plugin_" + pluginName, new Plugin(this, options)
      return

  return
) jQuery, window, document
