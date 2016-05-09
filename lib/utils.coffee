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

sequence = (functions...) ->
  (parameters...) ->
    functions.forEach (fn) -> fn(parameters...)

lazy = (action, lazyParams...) ->
  (params...) ->
    evaluatedParams = lazyParams.map (param) -> do param
    action(evaluatedParams...)?(params...)

injecting = (action, params...) ->
  () -> action params...

applyConditionally = (action, predicate) ->
  do action if do predicate

module.exports = {withActiveEditor, withAllCursors, isEmpty, moveToEndOnLine, moveToBeginningOfFirstWord, isEndOfString,
  nothing, adviceBefore, adviceAfter, executeAround, lazy, injecting, applyConditionally, sequence}