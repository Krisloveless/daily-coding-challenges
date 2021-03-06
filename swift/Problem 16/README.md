### Description

This problem was asked by Twitter.

You run an e-commerce website and want to record the last `N` `order` ids in a log. Implement a data structure to accomplish this, with the following API:

* `record(order_id)`: adds the order_id to the log
* `get_last(i)`: gets the ith last element from the log. i is guaranteed to be smaller than or equal to N.

You should be as efficient with time and space as possible.

### Solution

```swift
class Node {
    var id: String
    var previous: Node?
    var next: Node?
    
    init(id: String) {
        self.id = id
        self.previous = nil
        self.next = nil
    }
}

struct Env {
    var head: Node? = nil
    var last: Node? = nil
    
    mutating func record(id: String) {
        let node = Node(id: id)
        
        if head == nil {
            head = node
            return
        }
        
        if last == nil {
            last = node
            last!.next = head
            last!.previous = head
            head!.next = last
            head!.previous = last
            return
        }
        
        if let last = last {
            node.previous = last
            node.next = head!
            
            last.next = node
            head!.previous = node
        }
        
        last = node
    }
    
    func getLast(i: Int) -> Node? {
        if head == nil {
            return nil
        }
        
        if last == nil {
            return head
        }

        var target: Node = head!
        
        for _ in 0...(i-1) {
            guard let previous = target.previous else {
                return nil
            }
            
            // We're assuming ids are unique
            if previous.id != head!.id {
                target = previous
            } else {
                return nil
            }
        }
        
        return target
    }
}
```