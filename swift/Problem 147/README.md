## Description

Given a list, sort it using this method: `reverse(lst, i, j)`, which reverses `lst` from `i` to `j`.

## Solution
```swift
extension Array where Element == Int {
    func customSort() -> [Int] {
        var result = self
        
        var i = 1
        
        while i < result.count {
            if result[i-1] > result[i] {
                result = reverse(lst: result, from: i-1, to: i)
                i = 1
            } else {
                i += 1
            }
        }
        
        return result
    }
    
    func reverse(lst: [Int], from: Int, to: Int) -> [Int] {
        var result: [Int] = []
        
        var part1: [Int] = []
        var part2: [Int] = []
        var part3: [Int] = []
        
        if from > 0 {
            part1 = Array(lst[0...from-1])
            result.append(contentsOf: part1)
        }
        
        part2 = Array(lst[from...to])
        part2.reverse()
        result.append(contentsOf: part2)
        
        if to < lst.count-1 {
            part3 = Array(lst[to+1...lst.count-1])
            result.append(contentsOf: part3)
        }
        
        return result
    }
}
```

## Test

```swift
class Problem_147Tests: XCTestCase {

    func test_custom_sort() {
        let input = [3, 1, 4, 2]
        
        XCTAssert(input.customSort() == [1, 2, 3, 4])
    }

}
```