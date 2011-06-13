$ = jQuery

sides =
  front:  {rotateY: '0deg',    rotateX: '0deg'}
  back:   {rotateX: '-180deg', rotateX: '0deg'}
  right:  {rotateY: '-90deg',  rotateX: '0deg'}
  left:   {rotateY: '90deg',   rotateX: '0deg'}
  top:    {rotateY: '0deg',    rotateX: '-90deg'}
  bottom: {rotateY: '0deg',    rotateX: '90deg'}

defaults = 
  width: 300
  height: 300

$.fn.gfxCube = (options) ->
  opts = $.extend({}, defaults, options)
  
  element = $(@)
  
  tZ = opts.translateZ or opts.width / 2
  tZ += 'px' if typeof tZ is 'number'
  
  element.transform
    position: 'relative'
    width:  opts.width
    height: opts.height
    '-webkit-perspective': '3000'
    '-webkit-perspective-origin': '50% 50%'
    
  wrapper = $('<div />')
  wrapper.addClass('gfxCubeWrapper')
  wrapper.transform
    position: 'absolute'
    width: '100%'
    height: '100%'
    left: 0
    top: 0
    overflow: 'visible'
    rotateY: '0deg'
    rotateX: '0deg'
    translateZ: "-#{tZ}"
    '-webkit-transform-style': 'preserve-3d'
    '-webkit-transform-origin': '50% 50%'    
    
  element.children().wrapAll(wrapper).css
    display: 'block'
    position: 'absolute'
    width: '100%'
    height: '100%'
    left: 0
    top: 0
    overflow: 'hidden'
    
  front   = element.find('.front')
  back    = element.find('.back')
  right   = element.find('.right')
  left    = element.find('.left')
  top     = element.find('.top')
  bottom  = element.find('.bottom')
  
  front.transform   rotateY: '0deg',   translateZ: tZ
  back.transform    rotateY: '180deg', translateZ: tZ
  right.transform   rotateY: '90deg',  translateZ: tZ
  left.transform    rotateY: '-90deg', translateZ: tZ
  top.transform     rotateX: '90deg',  translateZ: tZ
  bottom.transform  rotateX: '-90deg', translateZ: tZ
  
  $(@).bind 'cube', (e, type) ->
    wrapper = element.find('.gfxCubeWrapper')
    console.log $.extend({}, {translateZ: "-#{tZ}"}, sides[type])
    wrapper.gfx($.extend({}, {translateZ: "-#{tZ}"}, sides[type]))

$.fn.gxfxCubeIn = (options = {}) ->
  $(@).queueNext ->
    $(@).transform(rotateY: '90deg', display: 'block')
  $(@).gfx({rotateY: 0}, options)
  
$.fn.gxfxCubeOut = (options = {}) ->
  $(@).css
    '-webkit-backface-visibility': 'hidden'
  $(@).gfx({rotateY: '-90deg'}, options)
  $(@).queueNext ->
    $(@).transform(rotateY: 0, display: 'none')
  