## Description

This problem was asked by Microsoft.

Print the nodes in a binary tree level-wise. For example, the following should print 1, 2, 3, 4, 5.

```
  1
 / \
2   3
   / \
  4   5
```

## Solution

```swift
class Node<T> {
    var value: T
    var left: Node<T>?
    var right: Node<T>?
    
    init(value: T, left: Node<T>?, right: Node<T>?) {
        self.value = value
        self.left = left
        self.right = right
    }
    
    func printTree(level: Int = 0) {
        let dictionary = valuesToDictionary()
        let sortedKeys = dictionary.keys.sorted{ $0 < $1 }
        
        var result = ""
        
        for key in sortedKeys {
            for value in dictionary[key]! {
                result += value
            }
        }
        
        print(result.prefix(result.count-1))
    }
    
    private func valuesToDictionary(level: Int = 0) -> [Int : [String]] {
        var result: [Int : [String]] = [:]
        
        result[level] = ["\(value),"]
        
        if let left = left {
            let leftDictionary = left.valuesToDictionary(level: level+1)
            
            for key in leftDictionary.keys {
                if !result.keys.contains(key) {
                    result[key] = []
                }
                
                for leftKey in leftDictionary[key]! {
                    result[key]!.append("\(leftKey)")
                }
            }
        }
        
        if let right = right {
            let rightDictionary = right.valuesToDictionary(level: level+1)
            
            for key in rightDictionary.keys {
                if !result.keys.contains(key) {
                    result[key] = []
                }
                
                for rightKey in rightDictionary[key]! {
                    result[key]!.append("\(rightKey)")
                }
            }
        }
        
        return result
    }
}
```

## Test

```swift
class Problem_107Tests: XCTestCase {

    func test_example() {
        let root = Node<Int>(value: 1, left: Node<Int>(value: 2, left: nil, right: nil), right: Node<Int>(value: 3, left: Node<Int>(value: 4, left: nil, right: nil), right: Node<Int>(value: 5, left: nil, right: nil)))
        _ = root.printTree()
    }

}
```