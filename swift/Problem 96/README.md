## Description

This problem was asked by Microsoft.

Given a number in the form of a list of digits, return all possible permutations.

For example, given `[1,2,3]`, return `[[1,2,3],[1,3,2],[2,1,3],[2,3,1],[3,1,2],[3,2,1]]`.

## Solution

```swift
extension Array where Element == Int {
    
    func allPermutations() -> [[Int]] {
        var result: [[Int]] = []
        
        for i in 0..<count {
            var copyCandidate = self
            
            result.append(contentsOf: [copyCandidate.remove(at: i)].next(candidates: copyCandidate))
        }
        
        return result
    }
    
    func next(candidates: [Int]) -> [[Int]] {
        var result: [[Int]] = []
        
        for i in 0..<candidates.count {
            var copy = self
            var copyCandidates = candidates
            
            copy.append(copyCandidates.remove(at: i))
            
            if copyCandidates.isEmpty {
                result.append(contentsOf: [copy])
            } else {
                result.append(contentsOf: copy.next(candidates: copyCandidates))
            }
        }
        
        return result
    }
}
```

## Test

```swift
class Problem_96Tests: XCTestCase {

    func test_example() {
        let input = [1,2,3]
        print(input.allPermutations())
    }

}
```