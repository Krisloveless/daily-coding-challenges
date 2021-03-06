## Description

This problem was asked by Facebook.

Given a positive integer `n`, find the smallest number of squared integers which sum to `n`.

For example, given `n` = 13, return 2 since 13 = 32 + 22 = 9 + 4.

Given `n` = 27, return 3 since 27 = 32 + 32 + 32 = 9 + 9 + 9.

## Solution

```swift
struct FacebookChallenge {
    
    func smallestNumberOfSquaredInteger(target: Int) -> Int? {
        
        return candidatesToMinNumberOfSquare(toReach: target).min()
    }
    
    private func candidatesToMinNumberOfSquare(toReach: Int) -> [Int] {
        
        var result: [Int] = []
        
        if toReach == 1 {
            result.append(1)
        } else {
            for i in 1...toReach/2 {
                if i * i == toReach {
                    result.append(i)
                } else if i * i < toReach {
                    if let min = candidatesToMinNumberOfSquare(toReach: toReach - (i * i)).min() {
                        result.append(1 + min)
                    }
                }
            }
        }
        
        return result
    }
}
```

## Test

```swift
class Problem_156Tests: XCTestCase {

    func test_example() {
        XCTAssert(FacebookChallenge().smallestNumberOfSquaredInteger(target: 13) == 3)
    }

}
```