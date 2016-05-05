{positionings, calculatePositioning} = require '../lib/vertical'

describe "vertical", ->
  describe "positionings", ->
    it 'contains expected positionings', ->
      expectedPositonings = [
        'endOfLine'
        'beginningOfFirstWord'
        'normal'
      ]
      expectedPositonings.forEach (positioning) -> expect(positionings[positioning]).toBeDefined()

  describe "calculatePositioning", ->
    it 'returns positionings.endOfLine for end of line', ->
      expect(calculatePositioning 'a', 1).toBe positionings.endOfLine
    it 'returns positionings.beginningOfFirstWord for beginning of first word', ->
      expect(calculatePositioning ' a', 1).toBe positionings.beginningOfFirstWord
    it 'returns positionings.normal for general case', ->
      expect(calculatePositioning ' aa ', 2).toBe positionings.normal

