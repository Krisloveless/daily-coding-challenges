## Description

This problem was asked by Jane Street.

Generate a finite, but an arbitrarily large binary tree quickly in O(1).

That is, `generate()` should return a tree whose size is unbounded but finite.

## Solution

```swift
class Node {
    var value: String
    var left: Node?
    var right: Node?
    
    init?(value: String, random: Bool = true) {
        if random && !Bool.random() {
            return nil
        } else {
            self.value = value
            self.left = Node(value: "")
            self.right = Node(value: "")
        }
    }
    
    func countNodes() -> Int {
        var result = 1
        
        if let left = left {
            result += left.countNodes()
        }
        
        if let right = right {
            result += right.countNodes()
        }
        
        return result
    }
}
```

## Test

```swift
class Problem_116Tests: XCTestCase {

    func test_random_tree() {
        let root = Node(value: "root", random: false)
        print(root?.countNodes())
    }

}
```