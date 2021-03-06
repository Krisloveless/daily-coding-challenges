## Description

This problem was asked by Facebook.

Given a `start` word, an `end` word, and a dictionary of valid words, find the shortest transformation sequence from `start` to `end` such that only one letter is changed at each step of the sequence, and each transformed word exists in the dictionary. If there is no possible transformation, return null. Each word in the dictionary have the same length as `start` and `end` and is lowercase.

For example, given `start = "dog"`, `end = "cat"`, and `dictionary = {"dot", "dop", "dat", "cat"}`, return `["dog", "dot", "dat", "cat"]`.

Given `start = "dog"`, `end = "cat"`, and `dictionary = {"dot", "tod", "dat", "dar"}`, return `null` as there is no possible transformation from `dog` to `cat`.

## Solution
    
```swift
extension Dictionary where Value == String {
    
    func transformation(from: String, to: String, previousTransformations: [String]) -> [String]? {
        
        if !self.values.contains(to) {
            return nil
        }
        
        var candidates: [[String]] = []
        
        for value in self.values {
            let fromToDiff = zip(from, to).filter{ $0 != $1 }
            let fromValueDiff = zip(from, value).filter{ $0 != $1 }
            let valueToDiff = zip(value, to).filter{ $0 != $1 }
            
            let rule1 = fromValueDiff.count == 1
            let rule2 = valueToDiff.count == fromToDiff.count-1
            
            if rule1 && rule2 {
                print("from: \(from), to: \(to), value: \(value)")
                var candidate = previousTransformations
                candidate.append(value)
                
                candidates.append(candidate)
            }
        }
        
        if candidates.isEmpty {
            return nil
        }
        
        if candidates.first!.last! == to {
            return candidates.first!
        }
        
        for candidate in candidates {
            if let possibility = transformation(from: candidate.last!, to: to, previousTransformations: candidate) {
                return possibility
            }
        }
        
        return nil
    }
    
    
}
```

## Test

```swift
class Problem_170Tests: XCTestCase {

    func test_example() {
        let dictionary = [1: "dot", 2: "dop", 3: "dat", 4: "cat"]
        XCTAssert(dictionary.transformation(from: "dog", to: "cat", previousTransformations: []) == ["dot", "dat", "cat"])
        
        let dictionary2 = [1: "dot", 2: "tod", 3: "dat", 4: "dar"]
        XCTAssertNil(dictionary2.transformation(from: "dog", to: "cat", previousTransformations: []))
    }

}
```