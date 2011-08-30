try
  describe("BGArrayIterator", ->
    ##############################
    # nextByItem
    ##############################
    describe("checking element counts in nextByItem", ->
      it("should count once for each element in the array", ->
        test_array = [1,2,3,4]
        test_count = 0
        iterator = new BGArrayIterator(test_array,1)
        while(not iterator.nextByItem(->test_count++))
          no_op=true
        expect(test_count==test_array.length).toBeTruthy()
      )
      it("should count once for each element in the array with batch size 2", ->
        test_array = [1,2,3,4]
        test_count = 0
        iterator = new BGArrayIterator(test_array,2)
        while(not iterator.nextByItem(->test_count++))
          no_op=true
        expect(test_count==test_array.length).toBeTruthy()
      )
      it("should count once for each element in the array with batch size 3 and an odd number of elements", ->
        test_array = [1,2,3,4,5]
        test_count = 0
        iterator = new BGArrayIterator(test_array,3)
        while(not iterator.nextByItem(->test_count++)) 
          no_op=true
        expect(test_count==test_array.length).toBeTruthy()
      )
    )
    describe("checking element values match in nextByItem", ->
      it("should refer to the correct elements in nextByItem batch size 1", ->
        test_array = [1,2,3,4]
        test_count = 0
        iterator = new BGArrayIterator(test_array,1)
        while(not iterator.nextByItem((item)->
          expect(item == test_array[test_count]).toBeTruthy()
          test_count++ 
        ))
          no_op=true
      )
      it("should refer to the correct elements in nextByItem batch size 3", ->
        test_array = [1,2,3,4, 5]
        test_count = 0
        iterator = new BGArrayIterator(test_array,1)
        while(not iterator.nextByItem((item)->
          expect(item == test_array[test_count]).toBeTruthy()
          test_count++ 
        ))
          no_op=true
      )
    )
    ##############################
    # nextBySlice
    ##############################
    describe("checking element counts in nextBySlice", ->
      it("should count once for each element in the array", ->
        test_array = [1,2,3,4]
        test_count = 0
        iterator = new BGArrayIterator(test_array,1)
        while(not iterator.nextBySlice((slice)->test_count++ for item in slice))
          no_op=true
        expect(test_count==test_array.length).toBeTruthy()
      )
      it("should count once for each element in the array with batch size 2", ->
        test_array = [1,2,3,4]
        test_count = 0
        iterator = new BGArrayIterator(test_array,2)
        while(not iterator.nextBySlice((slice)->test_count++ for item in slice))
          no_op=true
        expect(test_count==test_array.length).toBeTruthy()
      )
      it("should count once for each element in the array with batch size 3 and an odd number of elements", ->
        test_array = [1,2,3,4,5]
        test_count = 0
        iterator = new BGArrayIterator(test_array,3)
        while(not iterator.nextBySlice((slice)->test_count++ for item in slice))
          no_op=true
        expect(test_count==test_array.length).toBeTruthy()
      )
    )
    describe("checking element values match in nextBySlice", ->
      it("should refer to the correct elements in nextByItem batch size 1", ->
        test_array = [1,2,3,4]
        test_count = 0
        iterator = new BGArrayIterator(test_array,1)
        while(not iterator.nextBySlice((slice)->
          for item in slice
            do (item) ->
              expect(item == test_array[test_count]).toBeTruthy()
              test_count++ 
        ))
          no_op=true
      )
      it("should refer to the correct elements in nextBySlice batch size 3", ->
        test_array = [1,2,3,4,5]
        test_count = 0
        iterator = new BGArrayIterator(test_array,1)
        while(not iterator.nextBySlice((slice)->
          for item in slice
            do (item) ->
              expect(item == test_array[test_count]).toBeTruthy()
              test_count++ 
        ))
          no_op=true
      )
    )
    ##############################
    # nextByRange
    ##############################
    describe("checking element counts in nextByRange", ->
      it("should count once for each element in the array", ->
        test_array = [1,2,3,4]
        test_count = 0
        iterator = new BGArrayIterator(test_array,1)
        while(not iterator.nextByRange((range)->
          while(range.index<range.excluded_boundary) 
            test_count++
            range.index++
        ))
          no_op=true
        expect(test_count==test_array.length).toBeTruthy()
      )
      it("should count once for each element in the array with batch size 2", ->
        test_array = [1,2,3,4]
        test_count = 0
        iterator = new BGArrayIterator(test_array,2)
        while(not iterator.nextByRange((range)->
          while(range.index<range.excluded_boundary) 
            test_count++
            range.index++
        ))
          no_op=true
        expect(test_count==test_array.length).toBeTruthy()
      )
      it("should count once for each element in the array with batch size 3 and an odd number of elements", ->
        test_array = [1,2,3,4,5]
        test_count = 0
        iterator = new BGArrayIterator(test_array,3)
        while(not iterator.nextByRange((range)->
          while(range.index<range.excluded_boundary) 
            test_count++
            range.index++
        ))
          no_op=true
        expect(test_count==test_array.length).toBeTruthy()
      )
    )
    describe("checking element values match in nextByRange", ->
      it("should refer to the correct elements in nextByItem batch size 1", ->
        test_array = [1,2,3,4]
        test_count = 0
        iterator = new BGArrayIterator(test_array,1)
        while(not iterator.nextByRange((range, array)->
          while(range.index<range.excluded_boundary) 
            expect(array[range.index] == test_array[test_count]).toBeTruthy()
            range.index++
            test_count++
        ))
          no_op=true
      )
      it("should refer to the correct elements in nextByRange batch size 3", ->
        test_array = [1,2,3,4,5]
        test_count = 0
        iterator = new BGArrayIterator(test_array,1)
        while(not iterator.nextByRange((range, array)->
          while(range.index<range.excluded_boundary) 
            expect(array[range.index] == test_array[test_count]).toBeTruthy()
            range.index++
            test_count++
        ))
          no_op=true
      )
    )
    ##############################
    # Manually using step()
    ##############################
    describe("checking element counts using step()", ->
      it("should count once for each element in the array", ->
        test_array = [1,2,3,4]
        test_count = 0
        iterator = new BGArrayIterator(test_array,1)
        while(not iterator.isDone())
          range = iterator.step()
          while(range.index<range.excluded_boundary) 
            test_count++
            range.index++
        expect(test_count==test_array.length).toBeTruthy()
      )
      it("should count once for each element in the array with batch size 2", ->
        test_array = [1,2,3,4]
        test_count = 0
        iterator = new BGArrayIterator(test_array,2)
        while(not iterator.isDone())
          range = iterator.step()
          while(range.index<range.excluded_boundary) 
            test_count++
            range.index++
        expect(test_count==test_array.length).toBeTruthy()
      )
      it("should count once for each element in the array with batch size 3 and an odd number of elements", ->
        test_array = [1,2,3,4,5]
        test_count = 0
        iterator = new BGArrayIterator(test_array,3)
        while(not iterator.isDone())
          range = iterator.step()
          while(range.index<range.excluded_boundary) 
            test_count++
            range.index++
        expect(test_count==test_array.length).toBeTruthy()
      )
    )
    describe("checking element values match using step()", ->
      it("should refer to the correct elements in nextByItem batch size 1", ->
        test_array = [1,2,3,4]
        test_count = 0
        iterator = new BGArrayIterator(test_array,1)
        while(not iterator.isDone())
          range = iterator.step()
          while(range.index<range.excluded_boundary) 
            expect(test_array[range.index] == test_array[test_count]).toBeTruthy()
            range.index++
            test_count++
      )
      it("should refer to the correct elements in step batch size 3", ->
        test_array = [1,2,3,4,5]
        test_count = 0
        iterator = new BGArrayIterator(test_array,1)
        while(not iterator.isDone())
          range = iterator.step()
          while(range.index<range.excluded_boundary) 
            expect(test_array[range.index] == test_array[test_count]).toBeTruthy()
            range.index++
            test_count++
      )
    )
  )

catch error
  alert("BGArrayIterator specs failed: '#{error}'")