(($, window, document) ->

  "use strict"

  # Create the defaults once
  pluginName = "gallerize"
  defaults = propertyName: "value"

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
      console.log "xD"
      return
    yourOtherFunction: ->
      return

  # A really lightweight plugin wrapper around the constructor,
  # preventing against multiple instantiations
  $.fn[pluginName] = (options) ->
    @each ->
      if !$.data(this, "plugin_" + pluginName)
        $.data this, "plugin_" + pluginName, new Plugin(this, options)
      return

  return
) jQuery, window, document
