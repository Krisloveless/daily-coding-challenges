## Description

This problem was asked by Stripe.

Given a collection of intervals, find the minimum number of intervals you need to remove to make the rest of the intervals non-overlapping.

Intervals can "touch", such as `[0, 1]` and `[1, 2]`, but they won't be considered overlapping.

For example, given the intervals `(7, 9), (2, 4), (5, 8)`, return 1 as the last interval can be removed and the first two won't overlap.

The intervals are not necessarily sorted in any order.

## Solution

```swift
typealias Interval = (start: Int, end: Int)

func overlaps(left: Interval, right: Interval) -> Bool {
    
    let c1 = left.end < right.end && left.end > right.end
    let c2 = right.end < left.end && right.end > left.end
    
    let c3 = left.start < right.start && left.end > right.start
    let c4 = right.start < left.start && right.end > left.start
    
    return c1 || c2 || c3 || c4
}

func overlaps(left: Interval, rights: [Interval]) -> Bool {
    
    for right in rights {
        let c1 = left.end < right.end && left.end > right.end
        let c2 = right.end < left.end && right.end > left.end
        
        let c3 = left.start < right.start && left.end > right.start
        let c4 = right.start < left.start && right.end > left.start
        
        if c1 || c2 || c3 || c4 {
            return true
        }
    }
    
    return false
}

extension Array where Element == Interval {
    
    func largestNonOverlappingSubset() -> ([Interval], currentlyRemoved: Int) {
        
        var candidates: [([Interval], currentlyRemoved: Int)] = []
        
        for i in 0..<count {
            var copy = self
            let current = copy.remove(at: i)
            
            if overlaps(left: current, rights: copy) {
                candidates.append(copy.removeNext(currentlyRemoved: 1))
            }
        }
        
        _ = candidates.sorted{ $0.currentlyRemoved < $1.currentlyRemoved }
        
        return candidates.first!
    }
    
    func removeNext(currentlyRemoved: Int) -> ([Interval], currentlyRemoved: Int) {
        
        var results: [([Interval], currentlyRemoved: Int)] = []
        
        for i in 0..<count {
            var copy = self
            let current = copy.remove(at: i)
            
            if overlaps(left: current, rights: copy) {
                results.append((copy, currentlyRemoved + 1))
                return (copy, currentlyRemoved + 1)
            }
        }
        
        if results.isEmpty {
            return (self, currentlyRemoved)
        }
        
        _ = results.sorted{ $0.currentlyRemoved < $1.currentlyRemoved }
        return results.first!
    }
}
```

## Test

```swift
class Problem_191Tests: XCTestCase {

    func test_example() {
        let input: [Interval] = [(7, 9), (2, 4), (5, 8)]
        let result = input.largestNonOverlappingSubset()
        
        print(result.0)
        XCTAssert(result.currentlyRemoved == 1)
    }
    
    func test_with_unique_possibility() {
        let input: [Interval] = [(1, 3), (2, 4), (1, 2)]
        let result = input.largestNonOverlappingSubset()
        
        print(result.0)
        XCTAssert(result.currentlyRemoved == 1)
    }

}
```