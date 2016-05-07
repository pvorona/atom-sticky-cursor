{getBehavior, positionings, calculatePositioning, getPositioning, setPositioning} = require '../lib/movement-vertical'
{nothing, moveToBeginningOfFirstWord, moveToEndOnLine} = require '../lib/utils'

describe "movement-vertical", ->
  describe "positionings", ->
    it 'contains expected positionings', ->
      [
        'endOfLine'
        'beginningOfFirstWord'
        'normal'
      ].forEach (positioning) -> expect(positionings[positioning]).toBeDefined()

  describe "calculatePositioning", ->
    it 'returns positionings.endOfLine for end of line', ->
      expect(calculatePositioning 'a', 1).toBe positionings.endOfLine
    it 'returns positionings.beginningOfFirstWord for beginning of first word', ->
      expect(calculatePositioning ' a', 1).toBe positionings.beginningOfFirstWord
    it 'returns positionings.normal for general case', ->
      expect(calculatePositioning ' aa ', 2).toBe positionings.normal

  describe "getPositioning", ->
    it 'returns on of expected positionings', ->
      expect(getPositioning()).toBe(positionings.beginningOfFirstWord)

  describe "setPositioning", ->
    it 'changes positioning', ->
      setPositioning positionings.normal
      expect(getPositioning()).toBe(positionings.normal)

  describe "getBehavior", ->
    it 'returns moveToEndOnLine for positionings.endOfLine', ->
      expect(getBehavior(positionings.endOfLine)).toBe(moveToEndOnLine)

    it 'returns moveToBeginningOfFirstWord for positionings.beginningOfFirstWord', ->
      expect(getBehavior(positionings.beginningOfFirstWord)).toBe(moveToBeginningOfFirstWord)

    it 'returns nothing for positionings.normal', ->
      expect(getBehavior(positionings.normal)).toBe(nothing)
