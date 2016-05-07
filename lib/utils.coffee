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

adviceBefore = (action, advice) ->
  (parameters...) ->
    advice(parameters...)
    action(parameters...)

adviceAfter = (action, advice) ->
  (parameters...) ->
    action(parameters...)
    advice(parameters...)

executeAround = (action, before, after) ->
  adviceAfter adviceBefore(action, before), after

lazy = (action, lazyParams...) ->
  (params...) ->
    evaluatedParams = lazyParams.map (param) -> do param
    action(evaluatedParams...)?(params...)

module.exports = {withActiveEditor, withAllCursors, isEmpty, moveToEndOnLine, moveToBeginningOfFirstWord, isEndOfString,
  nothing, adviceBefore, adviceAfter, executeAround, lazy}