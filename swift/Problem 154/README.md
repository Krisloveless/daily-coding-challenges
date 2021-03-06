## Description

This problem was asked by Amazon.

Implement a stack API using only a heap. A stack implements the following methods:

- `push(item)`, which adds an element to the stack
- `pop()`, which removes and returns the most recently added element (or throws an error if there is nothing on the stack)

Recall that a heap has the following operations:

- `push(item)`, which adds a new key to the heap
- `pop()`, which removes and returns the max value of the heap

## Solution

```swift
class Stack {
    var heap: Heap
    var lastAddedKeys: [Int]
    
    init() {
        self.heap = Heap()
        self.lastAddedKeys = []
    }
    
    func push(item: Int) {
        self.heap.push(item: item)
        lastAddedKeys.append(item)
    }
    
    func pop() -> Int? {
        var trace: [Int] = []
        
        while (true) {
            guard let next = heap.pop() else {
                return nil
            }
            
            if let lastAdded = lastAddedKeys.last, next == lastAdded {
                for item in trace {
                    self.heap.push(item: item)
                }
                
                lastAddedKeys.removeLast()
                return next
            }
            
            trace.append(next)
        }
    }
}

class Heap {
    var items: [Int]
    
    init() {
        self.items = []
    }
    
    func push(item: Int) {
        self.items.append(item)
    }
    
    func pop() -> Int? {
        guard self.items.count > 0 else {
            return nil
        }
        
        var sorted = self.items.sorted()
        let item = sorted.removeLast()
        
        self.items = sorted
        
        return item
    }
}
```

## Test

```swift
class Problem_154Tests: XCTestCase {

    func test_stack() {
        let stack = Stack()
        
        stack.push(item: 0)
        stack.push(item: 1)
        stack.push(item: 2)
        
        XCTAssert(stack.pop() == 2)
        
        stack.push(item: 3)
        stack.push(item: -1)
        
        XCTAssert(stack.pop() == -1)
        XCTAssert(stack.pop() == 3)
    }

}
```