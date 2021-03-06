## Description

This problem was asked by Google.

Given the head of a singly linked list, swap every two nodes and return its head.

For example, given `1 -> 2 -> 3 -> 4`, return `2 -> 1 -> 4 -> 3`.

## Solution

```swift
class Node {
    var value: Int
    var next: Node?
    
    init(value: Int, next: Node?) {
        self.value = value
        self.next = next
    }
    
    func swapPairs() -> Node? {
        let allNodes = nodes()
        var root: Node? = nil
        var current: Node? = nil
        
        for i in 0..<allNodes.count {
            if i % 2 != 0 {
                let copy = allNodes[i]
                copy.next = allNodes[i-1]
                
                if current != nil {
                    current?.next = copy
                }
                
                if root == nil {
                    root = copy
                }
                
                current = copy.next
            }
        }
        
        current?.next = nil
        
        return root
    }
    
    func nodes() -> [Node] {
        var result: [Node] = [self]
        
        if let next = next {
            result.append(contentsOf: next.nodes())
        }
        
        return result
    }
    
    func toString() -> String {
        var result = "\(value)"
        
        if let next = next {
            result += "->\(next.toString())"
        }
        
        return result
    }
}
```

## Test

```swift
class Problem_145Tests: XCTestCase {

    func test_example() {
        let list = Node(value: 1, next: Node(value: 2, next: Node(value: 3, next: Node(value: 4, next: nil))))
        
        XCTAssert(list.toString() == "1->2->3->4")
        let swapped = list.swapPairs()
        XCTAssert(swapped?.toString() == "2->1->4->3")
    }

}
```