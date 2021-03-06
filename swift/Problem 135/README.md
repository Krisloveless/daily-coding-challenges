## Description

This question was asked by Apple.

Given a binary tree, find a minimum path sum from root to a leaf.

For example, the minimum path in this tree is [10, 5, 1, -1], which has sum 15.

```
  10
 /  \
5    5
 \     \
   2    1
       /
     


## Solution

```swift
// MARK: - TODO
```

## Solution

```swift
import Foundation

class Node {
    var value: Int
    var left: Node?
    var right: Node?
    
    init(value: Int) {
        self.value = value
        self.left = nil
        self.right = nil
    }
    
    func minPath() -> [Node] {        
        let paths = allPaths(current: [self])
        let sums = paths.map{ $0.map{ $0.value }.reduce(0, +) }
        let min = sums.min()
        let minIndex = sums.indices.filter{ sums[$0] == min! }
        
        return paths[minIndex.first!]
    }
    
    private func allPaths(current: [Node]) -> [[Node]] {
        
        if left == nil && right == nil {
            return [current]
        }
        
        var result: [[Node]] = []
        
        if let left = left {
            var new = current
            new.append(left)
            
            result.append(contentsOf: left.allPaths(current: new))
        }
        
        if let right = right {
            var new = current
            new.append(right)
            
            result.append(contentsOf: right.allPaths(current: new))
        }
        
        return result
    }
}
```

## Test

```swift
class Problem_135Tests: XCTestCase {

    func test_example() {
        let root = Node(value: 10)
        
        let l = Node(value: 5)
        root.left = l
        
        let lr = Node(value: 2)
        l.right = lr
        
        let r = Node(value: 5)
        root.right = r
        
        let rr = Node(value: 1)
        r.right = rr
        
        let rrl = Node(value: -1)
        rr.left = rrl
        
        print(root.minPath().map{ $0.value } == [10, 5, 1, -1])
    }

}
```