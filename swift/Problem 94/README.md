## Description

This problem was asked by Google.

Given a binary tree of integers, find the maximum path sum between two nodes. The path must go through at least one node, and does not need to go through the root.

## Solution

```swift
class Node {
    var val: Int
    var left: Node?
    var right: Node?
    
    init(val: Int, left: Node?, right: Node?) {
        self.val = val
        self.left = left
        self.right = right
    }
    
    func pathSums() -> (left: Int, right: Int) {
        var result = (left: 0, right: 0)
        
        if let left = left {
            result.left = left.val + val
        }
        
        if let right = right {
            result.right = right.val + val
        }
        
        return result
    }
    
    func maxPathSum() -> Int {
        if left != nil && right != nil {
            return max(pathSums().left, pathSums().right, left!.maxPathSum(), right!.maxPathSum())
        } else if left != nil {
            return max(pathSums().left, pathSums().right, left!.maxPathSum())
        } else if right != nil {
            return max(pathSums().left, pathSums().right, right!.maxPathSum())
        } else {
            return max(pathSums().left, pathSums().right)
        }
    }
}
```
## Test

```swift
class Problem_94Tests: XCTestCase {

    func test_1() {
        let tree = Node(val: 10, left: Node(val: 12, left: nil, right: nil), right: Node(val: 2, left: nil, right: nil))
        
        XCTAssert(tree.maxPathSum() == 22)
    }
    
    func test_2() {
        let tree = Node(val: 10, left: Node(val: 12, left: nil, right: nil), right: Node(val: 38, left: nil, right: nil))
        
        XCTAssert(tree.maxPathSum() == 48)
    }
    
    func test_3() {
        let tree = Node(val: 10, left: Node(val: 12, left: nil, right: Node(val: 38, left: nil, right: nil)), right: Node(val: 38, left: nil, right: nil))
        
        XCTAssert(tree.maxPathSum() == 50)
    }

}
```