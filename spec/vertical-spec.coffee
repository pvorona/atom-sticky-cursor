{positionings, calculatePositioning} = require '../lib/movement-vertical'

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