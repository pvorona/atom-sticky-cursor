{sticky} = require  './movement-vertical'
{skippingIndentationLeft, skippingIndentationRight} = require  './horizontal'
{withActiveEditor, withAllCursors} = require './utils'

commands =
  'sticky-cursor:move-up'       : () -> withActiveEditor withAllCursors sticky (cursor) -> cursor.moveUp()
  'sticky-cursor:move-down'     : () -> withActiveEditor withAllCursors sticky (cursor) -> cursor.moveDown()
  'sticky-cursor:move-up-by-3'  : () -> withActiveEditor withAllCursors sticky (cursor) -> cursor.moveUp(3)
  'sticky-cursor:move-down-by-3': () -> withActiveEditor withAllCursors sticky (cursor) -> cursor.moveDown(3)
  'sticky-cursor:move-left'     : () -> withActiveEditor withAllCursors skippingIndentationLeft (cursor) -> cursor.moveLeft()
  'sticky-cursor:move-right'    : () -> withActiveEditor withAllCursors skippingIndentationRight (cursor) -> cursor.moveRight()

module.exports = {commands}