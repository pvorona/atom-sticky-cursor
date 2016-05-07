{isEmpty, isEndOfString, adviceBefore, adviceAfter, executeAround, lazy} = require '../lib/utils'

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

  describe "adviceBefore", ->
    it 'should return function', ->
      main   = ->
      advice = ->
      expect(adviceBefore main, advice).not.toThrow()

    it 'should execute advice and main function', ->
      main   = jasmine.createSpy()
      advice = jasmine.createSpy()
      do adviceBefore main, advice
      expect(main).toHaveBeenCalled()
      expect(advice).toHaveBeenCalled()

    it 'should call both functions with arguments', ->
      main       = jasmine.createSpy()
      advice     = jasmine.createSpy()
      parameters = jasmine.createSpy()
      adviceBefore(main, advice)(parameters)
      expect(main).toHaveBeenCalledWith(parameters)
      expect(advice).toHaveBeenCalledWith(parameters)

  describe "adviceAfter", ->
    it 'should return function', ->
      main   = ->
      advice = ->
      expect(adviceBefore main, advice).not.toThrow()

    it 'should execute advice and main function', ->
      main   = jasmine.createSpy()
      advice = jasmine.createSpy()
      do adviceAfter main, advice
      expect(main).toHaveBeenCalled()
      expect(advice).toHaveBeenCalled()

    it 'should call both functions with arguments', ->
      main       = jasmine.createSpy()
      advice     = jasmine.createSpy()
      parameters = jasmine.createSpy()
      adviceAfter(main, advice)(parameters)
      expect(main).toHaveBeenCalledWith(parameters)
      expect(advice).toHaveBeenCalledWith(parameters)

  describe "executeAround", ->
    it 'should return function', ->
      main   = ->
      before = ->
      after  = ->
      expect(executeAround main, before, after).not.toThrow()

    it 'should execute advice and main function', ->
      main   = jasmine.createSpy()
      before = jasmine.createSpy()
      after  = jasmine.createSpy()
      do executeAround main, before, after
      expect(main).toHaveBeenCalled()
      expect(before).toHaveBeenCalled()
      expect(after).toHaveBeenCalled()

    it 'should call both functions with arguments', ->
      action   = jasmine.createSpy()
      before = jasmine.createSpy()
      after  = jasmine.createSpy()
      params = jasmine.createSpy()

      executeAround(action, before, after)(params)

      expect(action).toHaveBeenCalledWith(params)
      expect(before).toHaveBeenCalledWith(params)
      expect(after).toHaveBeenCalledWith(params)

  describe "lazy", ->
    it 'returns function', ->
      action = jasmine.createSpy()
      getter = jasmine.createSpy()

      expect(lazy action, getter).not.toThrow()

    it 'doesnt call getter before executing', ->
      action = jasmine.createSpy()
      getter = jasmine.createSpy()

      lazy action, getter

      expect(getter).not.toHaveBeenCalled()

    it 'calls getter when executed', ->
      action = jasmine.createSpy()
      getter = jasmine.createSpy()

      do lazy action, getter

      expect(getter).toHaveBeenCalled()