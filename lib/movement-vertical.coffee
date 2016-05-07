{isEmpty, moveToEndOnLine, moveToBeginningOfFirstWord, isEndOfString, nothing, executeAround, lazy} = require './utils'

positionings =
  endOfLine            : 'endOfLine'
  beginningOfFirstWord : 'beginningOfFirstWord'
  normal               : 'normal'

positioning = positionings.beginningOfFirstWord

calculatePositioning = (line, column) ->
  return positionings.endOfLine            if isEndOfString line, column
  return positionings.beginningOfFirstWord if isEmpty line.slice 0, column
  return positionings.normal

getBehavior = (positioning) ->
  switch positioning
    when positionings.endOfLine            then moveToEndOnLine
    when positionings.beginningOfFirstWord then moveToBeginningOfFirstWord
    when positionings.normal               then nothing

getPositioning = () ->
  positioning

before = (cursor) ->
  line = cursor.getCurrentBufferLine()
  if not isEmpty line
    positioning = calculatePositioning line, cursor.getBufferColumn()

sticky = (action) ->
  executeAround action, before, lazy getBehavior, getPositioning

module.exports = {sticky, positionings, calculatePositioning}