{isEmpty, isEndOfString} = require '../lib/utils'

describe "utils", ->
  describe "isEmpty", ->
    it 'returns true for empty strings', ->
      expect(isEmpty '  ').toBe(true)

    it 'returns false for non-empty strings', ->
      expect(isEmpty 'aa   b   c   ').toBe(false)

  describe "isEndOfString", ->
    it 'returns true when at end of line', ->
      expect(isEndOfString 'abc', 3).toBe(true)

    it 'returns false when not at end of line', ->
      expect(isEndOfString 'abc', 0).toBe(false)
      expect(isEndOfString 'abc', 1).toBe(false)
      expect(isEndOfString 'abc', 2).toBe(false)


