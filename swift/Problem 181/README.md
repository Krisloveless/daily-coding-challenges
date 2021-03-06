## Description

This problem was asked by Google.

Given a string, split it into as few strings as possible such that each string is a palindrome.

For example, given the input string racecarannakayak, return ["racecar", "anna", "kayak"].

Given the input string abc, return ["a", "b", "c"].

## Solution

```swift
extension String {
    
    func splitInPalindromes() -> [String] {
        var copy = self
        var result: [String] = []
        
        while !copy.isEmpty {
            let next = copy.nextPalindrome()
            result.append(next)
            copy = String(copy.suffix(copy.count-next.count))
        }
        
        return result
    }
    
    private func nextPalindrome() -> String {
        var result = ""
        var current = ""
        
        for character in self {
            current = "\(current)\(character)"
            if current.isPalindrom() {
                result = current
            }
        }
        
        return result
    }
    
    private func isPalindrom() -> Bool {
        return prefix(count/2) == String(suffix(count/2).reversed())
    }
}
```

## Test

```swift
class Problem_181Tests: XCTestCase {

    func test_example_1() {
        XCTAssert("racecarannakayak".splitInPalindromes() == ["racecar", "anna", "kayak"])
    }
    
    func test_example_2() {
        XCTAssert("abc".splitInPalindromes() == ["a", "b", "c"])
    }

}
```