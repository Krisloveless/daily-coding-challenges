## Description

This problem was asked by Google.

Given a set of distinct positive integers, find the largest subset such that every pair of elements in the subset (i, j) satisfies either i % j = 0 or j % i = 0.

For example, given the set [3, 5, 10, 20, 21], you should return [5, 10, 20]. Given [1, 3, 6, 24], return [1, 3, 6, 24].

## Solution

```swift
extension Array where Element == Int {
    
    /// find the largest subset such that every pair of elements in the subset (i, j) satisfies either i % j = 0 or j % i = 0.
    /// input must not have duplicates
    func largestSetWherePairsAreMultiple() -> [Int] {
        
        guard count == Set(self).count else {
            fatalError("`largestSetWherePairsAreMultiple()` does not accept duplicates")
        }
        
        let candidates = candidatesForLargestSetWherePairsAreMultiple()
        let sorted = candidates.sorted{ $0.count > $1.count }
        
        return sorted.first ?? []
    }
    
    private func candidatesForLargestSetWherePairsAreMultiple() -> [[Int]] {
        
        var result: [[Int]] = []
        
        if areAllPairsMultiple() {
            result.append(self)
        } else {
            for i in 0..<count {
                var copy = self
                copy.remove(at: i)
                
                result.append(contentsOf: copy.candidatesForLargestSetWherePairsAreMultiple())
            }
        }
        
        return result
    }
    
    private func areAllPairsMultiple() -> Bool {
        
        for i in 0..<count-1 {
            for j in i..<count {
                if !(self[i] % self[j] == 0 || self[j] % self[i] == 0) {
                    return false
                }
            }
        }
        
        return true
    }
}
```

## Test

```swift
class Problem_198Tests: XCTestCase {

    func test_example_1() {
        XCTAssert([3, 5, 10, 20, 21].largestSetWherePairsAreMultiple() == [5, 10, 20])
    }
    
    func test_example_2() {
        XCTAssert([1, 3, 6, 24].largestSetWherePairsAreMultiple() == [1, 3, 6, 24])
    }

}
```