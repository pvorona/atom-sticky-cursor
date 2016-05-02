emptyRe = /^\s*$/
state = 'bol'

withActiveEditor = (action) ->
  action atom.workspace.getActiveTextEditor()

withAllCursors = (action) -> (editor) ->
  editor.getCursors().forEach action

isEmpty = (string) ->
  emptyRe.test string

currentState = (cursor) ->
  return 'empty' if isEmpty cursor.getCurrentBufferLine()
  return 'eol'   if cursor.isAtEndOfLine()
  return 'bol'   if isEmpty cursor.getCurrentBufferLine().slice 0, cursor.getBufferColumn()
  return 'normal'

setState = (newState) ->
  state = newState unless newState is 'empty'

onEol = (cursor) ->
  cursor.moveToEndOfLine()

onBol = (cursor) ->
  cursor.moveToBeginningOfLine()
  cursor.moveToNextSubwordBoundary() if cursor.isSurroundedByWhitespace()

place = (cursor) ->
  switch state
    when 'eol' then onEol cursor
    when 'bol' then onBol cursor

sticky = (action) -> (cursor) ->
  setState currentState cursor
  action cursor
  place cursor

moveToEopl = (cursor) ->
  cursor.moveUp() unless cursor.isAtEndOfLine() and cursor.isAtBeginningOfLine()
  cursor.moveToEndOfLine()

moveToBonl = (cursor) ->
  cursor.moveToNextSubwordBoundary() unless cursor.isAtEndOfLine() and cursor.isAtBeginningOfLine() or not cursor.isSurroundedByWhitespace()

skippingIndentationLeft = (action) -> (cursor) ->
  action cursor
  moveToEopl cursor if isEmpty cursor.getCurrentBufferLine().slice 0, cursor.getBufferColumn() + 1

skippingIndentationRight = (action) -> (cursor) ->
  action cursor
  moveToBonl cursor if cursor.isAtBeginningOfLine()

module.exports = {
  withActiveEditor,
  withAllCursors,
  sticky,
  skippingIndentationLeft,
  skippingIndentationRight
}