## Description

This problem was asked by Facebook.

Write a function that rotates a list by k elements. For example, `[1, 2, 3, 4, 5, 6]` rotated by two becomes `[3, 4, 5, 6, 1, 2]`. Try solving this without creating a copy of the list. How many swap or move operations do you need?

## Solution

```swift
extension Array where Element == Int {
    
    mutating func rotate(by k: Int) -> [Int] {
        for _ in 1...k {
            shiftElements()
        }
        
        return self
    }
    
    mutating private func shiftElements() {
        for i in 0..<count-1 {
            swapIndexes(left: i, right: i+1)
        }
    }
    
    mutating private func swapIndexes(left: Int, right: Int) {
        guard left <= count else {
            fatalError("left index out of bound")
        }
        
        guard right <= count else {
            fatalError("right index out of bound")
        }
        
        let tmp = self[left]
        self[left] = self[right]
        self[right] = tmp
    }
}
```

## Test

```swift
class Problem_126Tests: XCTestCase {

    func test_example() {
        var input = [1, 2, 3, 4, 5, 6]
        
        XCTAssert(input.rotate(by: 2) == [3, 4, 5, 6, 1, 2])
    }

}
```