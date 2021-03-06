## Description

This question was asked by Snapchat.

Given the head to a singly linked list, where each node also has a “random” pointer that points to anywhere in the linked list, deep clone the list.

## Solution

```swift
class Node {
    var value: Int
    var next: Node?
    var rand: Node?
    
    init(value: Int, next: Node?, rand: Node?) {
        self.value = value
        self.next = next
        self.rand = rand
    }
    
    init(value: Int) {
        self.value = value
        self.next = nil
        self.rand = nil
    }
    
    func deepCopy(nodes: [Int: Node], rootKey: Int?) -> Node {
        var copyNodes = nodes
        
        let copy = self
        var rootKeyValue: Int!
        
        if let rootKey = rootKey {
            rootKeyValue = rootKey
        } else {
            rootKeyValue = copy.value
        }
        
        if let rand = copy.rand {
            copyNodes[rand.value] = rand
        }
        
        copyNodes[copy.value] = copy
        
        for key in copyNodes.keys {
            if copyNodes[key]!.rand!.value == copy.value {
                copyNodes[key]?.rand = copy
            }
        }
        
        if let next = next {
            return next.deepCopy(nodes: copyNodes, rootKey: rootKeyValue)
        } else {
            return copyNodes[rootKeyValue]!
        }
    }
    
    func values() -> String {
        var result = ""
        
        result += "\(self.value)"
        
        if let next = next {
            result += next.values()
        }
        
        return result
    }
}
```

## Test

```swift
class Problem_131Tests: XCTestCase {

    func test_deep_copy() {
        let root = Node(value: 0)
        let one = Node(value: 1)
        let two = Node(value: 2)
        
        root.rand = two
        one.rand = two
        two.rand = one
        
        root.next = one
        one.next = two
        
        let copy = root.deepCopy(nodes: [:], rootKey: nil)
        XCTAssert(root.values() == copy.values())
    }

}
```