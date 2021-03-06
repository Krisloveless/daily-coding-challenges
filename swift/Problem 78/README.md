## Description

This problem was asked by Google.

Given k sorted singly linked lists, write a function to merge all the lists into one sorted singly linked list.

## Solution

To create a singly linked list structure, I'll start with a node that keeps a reference to its next element
 
The singly linked list will hold a reference of its root

```swift
class Node<T> {
    var value: T
    var next: Node?
    
    init(value: T, next: Node? = nil) {
        self.value = value
        self.next = next
    }
}

class SortedLinkedList<T> where T: Comparable {
    
    var root: Node<T>?
    
    init(root: Node<T>?) {
        self.root = root
    }
    
    func insert(node: Node<T>) {
        if var current = root {
            while current.next != nil {
                // Sorted singly linked list: we're adding the node between a smaller and greater value
                if current.value <= node.value && current.next!.value >= node.value {
                    let next = current.next!
                    current.next = node
                    node.next = next
                    return
                }
                
                current = current.next!
            }
            
            current.next = node
        } else {
            root = node
        }
    }
    
    func merge(list: SortedLinkedList<T>) {
        guard var targetCurrent = list.root else {
            return
        }
        
        if var current = root {
            while current.next != nil {
                if current.value <= targetCurrent.value && current.next!.value >= targetCurrent.value {
                    let next = current.next!
                    let copy = targetCurrent
                    
                    // If that's the last node, then we're done
                    if copy.next == nil {
                        copy.next = next
                        current.next = copy
                        return
                    }
                    
                    // Otherwise, we swap the target with its next element and update the main list
                    targetCurrent = targetCurrent.next!
                    copy.next = next
                    current.next = copy
                    current = copy
                }
                
                current = current.next!
            }
        } else {
            root = targetCurrent
        }
        
    }
    
    // In a real situation, conforming to CustomStringConvertible would be idea
    func toString() -> String {
        var result = ""
        
        if var current = root {
            result.append("(\(current.value))")
            
            while current.next != nil {
                current = current.next!
                result.append("->(\(current.value))")
            }
        } else {
            result = "Empty list"
        }
        
        return result
    }
}
```

## Test

```swift
class Problem_78Tests: XCTestCase {

    func test_insert() {
        let root = Node(value: 1, next: Node(value: 2, next: Node(value: 3, next: nil)))
        let sortedLinkedList = SortedLinkedList(root: root)
        XCTAssert(sortedLinkedList.toString() == "(1)->(2)->(3)")
        
        sortedLinkedList.insert(node: Node(value: 2))
        XCTAssert(sortedLinkedList.toString() == "(1)->(2)->(2)->(3)")
    }
    
    func test_merge() {
        let root = Node(value: 1, next: Node(value: 3, next: Node(value: 5, next: nil)))
        let sortedLinkedList = SortedLinkedList(root: root)
        
        let root2 = Node(value: 2, next: Node(value: 4, next: Node(value: 6, next: nil)))
        let sortedLinkedList2 = SortedLinkedList(root: root2)
        
        sortedLinkedList.merge(list: sortedLinkedList2)
        XCTAssert(sortedLinkedList.toString() == "(1)->(2)->(3)->(4)->(5)")
    }

}
```