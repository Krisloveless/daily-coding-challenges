## Description

This problem was asked by Google.

Given the head of a singly linked list, reverse it in-place.

## Solution

First, let's define a linked list

```swift
class Node {
    var value: String
    var next: Node?
    
    init(value: String, next: Node?) {
        self.value = value
        self.next = next
    }
}

struct LinkedList {
    var head: Node?
}
```

A -> B -> C -> D has to become D -> C -> B -> A
 
We can store each node in an array, it would give us [A, B, C, D, A], reverse the array and rebuild the linked list

```swift
extension LinkedList {
    mutating func reverse() {
        if let linkedListHead = head {
            var orderedNodes: [Node] = linkedListHead.getList(current: [])
            
            var newHead: Node? = nil
            var current: Node? = nil
            
            for i in stride(from: orderedNodes.count-1, through: 0, by: -1) {
                
                if newHead == nil {
                    newHead = orderedNodes[i]
                    current = orderedNodes[i]
                } else {
                    current?.next = orderedNodes[i]
                    current = current?.next
                    
                    // End conidtion, make sure to avoid the loop
                    if i == 0 {
                        current?.next = nil
                    }
                }
            }
            
            head = newHead
        }
    }
}

extension Node {
    func getList(current: [Node]) -> [Node] {
        
        if let next = next {
            return next.getList(current: current + [self])
        }
        
        return current + [self]
    }
}
```

Utility class to visually display the linked list

```swift
extension LinkedList {
    func log() {
        if let head = head {
            var result: [String] = []
            
            for node in head.getList(current: []) {
                result.append(node.value)
            }
            
            print(result)
        }
    }
}
```

## Test

```swift
class Problem_73Tests: XCTestCase {

    func test_1() {
        let head = Node(value: "A", next: Node(value: "B", next: Node(value: "C", next: Node(value: "D", next: nil))))
        
        var linkedList = LinkedList(head: head)
        linkedList.log()
        
        linkedList.reverse()
        linkedList.log()
    }

}
```