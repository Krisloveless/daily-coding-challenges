## Description

This problem was asked by Facebook.

Given an N by N matrix, rotate it by 90 degrees clockwise.

For example, given the following matrix:

```
[[1, 2, 3],
 [4, 5, 6],
 [7, 8, 9]]
```

you should return:

```
[[7, 4, 1],
 [8, 5, 2],
 [9, 6, 3]]
```

Follow-up: What if you couldn't use any extra space?

## Solution
    
```swift
extension Array where Element == Array<Int> {
    
    mutating func rotate90() {
        
        let iteration = count / 2
        
        for i in 0..<iteration {
            
            let last = count - iteration
            
            for j in i..<last-i {
                print("i:\(i), j:\(j), last: \(last), iteration: \(iteration)")
                let temp = self[i][j]
                
                self[i][j] = self[last-j][i]
                self[last-j][i] = self[last-i][last-j]
                self[last-i][last-j] = self[j][last-i]
                self[j][last-i] = temp
            }
        }
        
    }
    
    mutating func flipFromDiagonal() {
        for i in 1..<count {
            for j in 0..<i {
                let temp = self[i][j]
                self[i][j] = self[j][i]
                self[j][i] = temp
            }
        }
    }
}
```

## Test

```swift
class Problem_168Tests: XCTestCase {

    func test_example() {
        var input = [
            [1, 2, 3],
            [4, 5, 6],
            [7, 8, 9]
        ]
        
        input.rotate90()
        print(input)
    }

}
```