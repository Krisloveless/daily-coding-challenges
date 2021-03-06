## Description

This problem was asked by Pinterest.

Given an integer list where each number represents the number of hops you can make, determine whether you can reach to the last index starting at index 0.

For example, `[2, 0, 1, 0]` returns `True` while `[1, 1, 0, 1]` returns `False`.

## Solution

```swift
extension Array where Element == Int {
    
    func canHopToTheEnd() -> Bool {
        var currentIndex = 0
        
        while currentIndex < count {
            currentIndex += self[currentIndex]
            
            // Condition where we can't hop anymore
            if self[currentIndex] == 0 && currentIndex < count-1 {
                return false
            }
            
            // Reached the end of the array
            if currentIndex == count-1 {
                return true
            }
            
            // We went pass the end of the array
            if currentIndex >= count {
                return false
            }
        }
        
        return false
    }
}
```

## Test

```swift
class Problem_106Tests: XCTestCase {

    func test_example_1() {
        let input = [2, 0, 1, 0]
        XCTAssert(input.canHopToTheEnd() == true)
    }
    
    func test_example_2() {
        let input = [1, 1, 0, 1]
        XCTAssert(input.canHopToTheEnd() == false)
    }

}
```