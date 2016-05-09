{sequence, applyConditionally, isEmpty, moveToEndOnLine, moveToBeginningOfFirstWord, isEndOfString, nothing,
  executeAround, lazy, injecting} = require './utils'

positionings =
  endOfLine            : 'endOfLine'
  beginningOfFirstWord : 'beginningOfFirstWord'
  normal               : 'normal'

positioning = positionings.beginningOfFirstWord

getPositioning = () ->
  positioning

setPositioning = (newPositioning) ->
  positioning = newPositioning

calculatePositioning = (line, column) ->
  return positionings.endOfLine            if isEndOfString line, column
  return positionings.beginningOfFirstWord if isEmpty line.slice 0, column
  return positionings.normal

getBehavior = (positioning) ->
  switch positioning
    when positionings.endOfLine            then moveToEndOnLine
    when positionings.beginningOfFirstWord then moveToBeginningOfFirstWord
    when positionings.normal               then nothing

shouldSetPositioning = (line) ->
  not isEmpty line

updatePositioning = (line, column) ->
  setPositioning calculatePositioning line, column

before = (cursor) ->
  applyConditionally injecting(updatePositioning, cursor.getCurrentBufferLine(), cursor.getBufferColumn()), injecting(shouldSetPositioning, cursor.getCurrentBufferLine())

sticky = (action) ->
  sequence before, action, lazy getBehavior, getPositioning

module.exports = {sticky, positionings, calculatePositioning, getPositioning, setPositioning, getBehavior, shouldSetPositioning}