{CompositeDisposable} = require 'atom'

isEmpty = /^\s*$/
state = 'bol'

withActiveEditor = (action) ->
  action atom.workspace.getActiveTextEditor()

withAllCursors = (action) -> (editor) ->
  editor.getCursors().forEach action

currentState = (cursor) ->
  return 'empty' if isEmpty.test cursor.getCurrentBufferLine()
  return 'eol'   if cursor.isAtEndOfLine()
  return 'bol'   if isEmpty.test cursor.getCurrentBufferLine().slice 0, cursor.getBufferColumn()
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

commands =
  'sticky-cursor:move-up':
    withActiveEditor.bind this, withAllCursors sticky (cursor) -> cursor.moveUp()
  'sticky-cursor:move-down':
    withActiveEditor.bind this, withAllCursors sticky (cursor) -> cursor.moveDown()

module.exports =
  activate: ->
    @subscriptions = new CompositeDisposable
    @subscriptions.add atom.commands.add 'atom-text-editor', commands

  deactivate: ->
    @subscriptions.dispose()
