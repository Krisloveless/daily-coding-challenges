## Description

This problem was asked by Amazon.

Given an array and a number k that's smaller than the length of the array, rotate the array to the right k elements in-place.

Return 2 as it occurs twice: once as the left leaf, and once as the sum of `2 + 5 - 5`.

## Solution

```swift
extension Array where Element == Int {
    
    mutating func rotate(k: Int) {
        for _ in 1...k {
            rotate()
        }
    }
    
    mutating private func rotate() {
        for i in stride(from: count-1, to: -1, by: -1) {
            
            if i == 0 {
                let tmp = self[i]
                self[i] = self[count-1]
                self[count-1] = tmp
            } else {
                let tmp = self[i-1]
                self[i-1] = self[i]
                self[i] = tmp
            }
            
        }
    }
}
```

## Test

```swift
class Problem_197Tests: XCTestCase {

    func test_rotate() {
        var input = [1, 2, 3, 4, 5]
        input.rotate(k: 3)
        let expected = [2, 3, 4, 1, 5]
        
        XCTAssert(input == expected)
    }

}
```