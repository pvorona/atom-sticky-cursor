{isEmpty} = require './utils'

moveToEndOfPreviousLine = (cursor) ->
  cursor.moveUp() unless cursor.isAtEndOfLine() and cursor.isAtBeginningOfLine()
  cursor.moveToEndOfLine()

moveToBeginningOfNextLine = (cursor) ->
  cursor.moveToNextSubwordBoundary() unless cursor.isAtEndOfLine() and cursor.isAtBeginningOfLine() or not cursor.isSurroundedByWhitespace()

skippingIndentationLeft = (action) -> (cursor) ->
  action cursor
  moveToEndOfPreviousLine cursor if isEmpty cursor.getCurrentBufferLine().slice 0, cursor.getBufferColumn() + 1

skippingIndentationRight = (action) -> (cursor) ->
  action cursor
  moveToBeginningOfNextLine cursor if cursor.isAtBeginningOfLine()

module.exports = {skippingIndentationLeft, skippingIndentationRight}