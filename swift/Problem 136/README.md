## Description

This question was asked by Google.

Given an N by M matrix consisting only of 1's and 0's, find the largest rectangle containing only 1's and return its area.

For example, given the following matrix:

```
[[1, 0, 0, 0],
 [1, 0, 1, 1],
 [1, 0, 1, 1],
 [0, 1, 0, 0]]
```

## Solution

```swift
extension Array where Element == Array<Int> {
    
    func largestIslandSize() -> Int {
        
        var previousRow: [Int] = Swift.Array(repeating: 0, count: self[0].count)
        var currentRow: [Int] = Swift.Array(repeating: 0, count: self[0].count)
        var currentMaxValue = 0
        
        for row in self {
            for i in 0..<row.count {
                if row[i] == 1 {
                    currentRow[i] = previousRow[i] + 1
                } else {
                    currentRow[i] = 0
                }
            }

            print("currentRow : \(currentRow)")
            let maxInRow = currentRow.mergeCommons().max() ?? 0
            currentMaxValue = Swift.max(currentMaxValue, maxInRow)
            previousRow = currentRow
        }
        
        return currentMaxValue
    }
}

extension Array where Element == Int {
    func mergeCommons() -> [Int] {
        
        var repartition: [Int: Int] = [:]
        
        for item in self {
            if repartition.keys.contains(item) {
                repartition[item]! += 1
            } else {
                repartition[item] = 1
            }
        }
        
        var result: [Int] = []
        
        for key in repartition.keys {
            result.append(key * repartition[key]!)
        }
        
        return result
    }
}
```

## Test

```swift
class Problem_136Tests: XCTestCase {

    func test_example() {
        let input = [
            [1, 0, 0, 0],
            [1, 0, 1, 1],
            [1, 0, 1, 1],
            [0, 1, 0, 0]
        ]
        
        XCTAssert(input.largestIslandSize() == 4)
    }

}
```