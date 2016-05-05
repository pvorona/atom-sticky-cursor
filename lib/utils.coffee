withActiveEditor = (action) ->
  action atom.workspace.getActiveTextEditor()

withAllCursors = (action) -> (editor) ->
  editor.getCursors().forEach action

isEmpty = (string) ->
  empty = /^\s*$/
  empty.test string

isEndOfString = (string, position) ->
  string.length is position

nothing = () ->

moveToEndOnLine = (cursor) ->
  cursor.moveToEndOfLine()

moveToBeginningOfFirstWord = (cursor) ->
  cursor.moveToBeginningOfLine()
  cursor.moveToNextSubwordBoundary() if cursor.isSurroundedByWhitespace()

module.exports = {withActiveEditor, withAllCursors, isEmpty, moveToEndOnLine, moveToBeginningOfFirstWord, isEndOfString,
  nothing}