{isEmpty, moveToEndOnLine, moveToBeginningOfFirstWord} = require './utils'

empty           = 'empty'
endOfLine       = 'eol'
beginningOfLine = 'bol'
normal          = 'normal'

positioning = beginningOfLine

calculateCurrentPositioning = (cursor) ->
  return empty if isEmpty cursor.getCurrentBufferLine()
  return endOfLine if cursor.isAtEndOfLine()
  return beginningOfLine if isEmpty cursor.getCurrentBufferLine().slice 0, cursor.getBufferColumn()
  return normal

setPositioning = (newPositioning) ->
  positioning = newPositioning unless newPositioning is empty

setPosition = (cursor) ->
  switch positioning
    when endOfLine then moveToEndOnLine cursor
    when beginningOfLine then moveToBeginningOfFirstWord cursor

sticky = (action) -> (cursor) ->
  setPositioning calculateCurrentPositioning cursor
  action cursor
  setPosition cursor

module.exports = {sticky}