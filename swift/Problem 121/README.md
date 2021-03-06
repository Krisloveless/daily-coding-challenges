## Description

This problem was asked by Google.

Given a string which we can delete at most k, return whether you can make a palindrome.

For example, given 'waterrfetawx' and a k of 2, you could delete f and x to get 'waterretaw'.

## Solution

```swift
extension String {
    func isPalindrome() -> Bool {
        return String(self.prefix(count / 2)) == String(self.suffix(count / 2).reversed())
    }
    
    func canBuildPalindrome(maxDeletion k: Int) -> Bool {
        if self.isPalindrome() {
            return true
        }
        
        guard k > 0 else {
            return false
        }
        
        for i in 0..<count {
            let remaining = "\(String(self.prefix(i)))\(String(self.suffix(count-i-1)))"
            
            if remaining.canBuildPalindrome(maxDeletion: k-1) {
                return true
            }
        }
        
        return false
    }
}
```

## Test

```swift
class Problem_121Tests: XCTestCase {

    func test_example() {
        let input = "waterrfetawx"
        XCTAssertTrue(input.canBuildPalindrome(maxDeletion: 2))
        XCTAssertFalse(input.canBuildPalindrome(maxDeletion: 1))
    }

}
```