## Description

This problem was asked by Google.

You are given an array of arrays of integers, where each array corresponds to a row in a triangle of numbers. For example, `[[1], [2, 3], [1, 5, 1]]` represents the triangle:

```
  1
 2 3
1 5 1
```

We define a path in the triangle to start at the top and go down one row at a time to an adjacent value, eventually ending with an entry on the bottom row. For example, 1 -> 3 -> 5. The weight of the path is the sum of the entries.

Write a program that returns the weight of the maximum weight path.

## Solution

```swift
extension Array where Element == [Int] {
    
    func maximumWeight() -> Int {
        
        guard count > 0 else {
            return 0
        }
        
        guard count > 1 else {
            return self[0][0]
        }
        
        let allCandidates = candidates(from: [self[0][0]], currentIndex: 0)
        let sorted = allCandidates.sorted{ $0.reduce(0, +) > $1.reduce(0, +) }
        
        return sorted.first!.reduce(0, +)
    }
    
    private func candidates(from: [Int], currentIndex: Int) -> [[Int]] {
        
        var result: [[Int]] = []
        
        if count == 1 {
            result.append(from)
            return result
        }
        
        var newArray: [[Int]] = []
        for i in 1..<count {
            newArray.append(self[i])
        }
        
        let leftValue = newArray[0][currentIndex]
        var newFrom = from
        newFrom.append(leftValue)
        
        result.append(contentsOf: newArray.candidates(from: newFrom, currentIndex: currentIndex))
        
        
        let rightValue = newArray[0][currentIndex+1]
        newFrom = from
        newFrom.append(rightValue)
        
        result.append(contentsOf: newArray.candidates(from: newFrom, currentIndex: currentIndex))
        
        return result
    }
}
```

## Test

```swift
class Problem_201Tests: XCTestCase {

    func test_example() {
        XCTAssert([[1], [2, 3], [1, 5, 1]].maximumWeight() == 9)
    }

}
```