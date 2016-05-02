{CompositeDisposable} = require 'atom'
{commands} = require './commands'

module.exports =
  activate: ->
    @subscriptions = new CompositeDisposable
    @subscriptions.add atom.commands.add 'atom-text-editor', commands

  deactivate: ->
    @subscriptions.dispose()