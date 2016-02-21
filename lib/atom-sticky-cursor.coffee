{CompositeDisposable} = require 'atom'

sticky = (action) ->
  emptyRe = /^\s*$/
  atom.workspace.getActiveTextEditor().getCursors().forEach (cursor) ->
    empty = emptyRe.test cursor.getCurrentBufferLine()
    eol = cursor.isAtEndOfLine()
    bol = emptyRe.test cursor.getCurrentBufferLine().slice 0, cursor.getBufferColumn()
    action cursor
    if eol and not empty
      cursor.moveToEndOfLine()
    else if bol
      cursor.moveToBeginningOfLine()
      cursor.moveToNextSubwordBoundary() if cursor.isSurroundedByWhitespace()

commands =
  'sticky-cursor:move-up':
    sticky.bind this, (cursor) -> cursor.moveUp()
  'sticky-cursor:move-down':
    sticky.bind this, (cursor) -> cursor.moveDown()

module.exports =
  activate: ->
    @subscriptions = new CompositeDisposable
    @subscriptions.add atom.commands.add 'atom-text-editor', commands

  deactivate: ->
    @subscriptions.dispose()
