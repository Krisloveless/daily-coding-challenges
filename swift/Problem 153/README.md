## Description

Find an efficient algorithm to find the smallest distance (measured in number of words) between any two given words in a string.

For example, given words "hello", and "world" and a text content of "dog cat hello cat dog dog hello cat world", return 1 because there's only one word "cat" in between the two words.

## Solution

```swift
extension String {
    
    func distance(between first: String, and second: String) -> Int {
        let splitted = self.split(separator: " ").map{ String($0) }

        guard splitted.contains(first), splitted.contains(second) else {
            return 0
        }
        
        var index = 0
        var current = ""
        var distance = Int.max
        
        for i in 0..<splitted.count {
            
            if splitted[i] == first {
                if current == second {
                    if distance > i - index {
                        distance = i - index
                    }
                }
                
                current = splitted[i]
                index = i
            }
            
            if splitted[i] == second {
                if current == first {
                    if distance > i - index {
                        distance = i - index
                    }
                }
                
                current = splitted[i]
                index = i
            }
        }
        
        return distance-1
    }
}
```

## Test

```swift
class Problem_153Tests: XCTestCase {

    func test_example() {
        XCTAssert("dog cat hello cat dog dog hello cat world".distance(between: "hello", and: "world") == 1)
    }

}
```