{commands} = require '../lib/commands'

describe "commands", ->
  it 'contains all expected commands', ->
    expectedCommands = [
      'sticky-cursor:move-up'
      'sticky-cursor:move-down'
      'sticky-cursor:move-up-by-3'
      'sticky-cursor:move-down-by-3'
      'sticky-cursor:move-left'
      'sticky-cursor:move-right'
    ]
    for expectedCommand in expectedCommands
      expect(commands[expectedCommand]).toBeDefined()