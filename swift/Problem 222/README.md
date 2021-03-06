## Description

This problem was asked by Quora.

Given an absolute pathname that may have . or .. as part of it, return the shortest standardized path.

For example, given "/usr/bin/../bin/./scripts/../", return "/usr/bin/".


## Solution

```swift
extension String {
    
    func shortestStandardizedPath() -> String {
        
        var splitted = self.split(separator: "/")
        splitted = splitted.filter{ $0 != "." }
        
        let absolutePath = self.first == "/"
        
        var keepLooping = true
        
        while keepLooping {
            for i in 0..<splitted.count {
                
                if splitted[i] == "." {
                    splitted.remove(at: i)
                    break
                }
                
                if i > 0 {
                    if splitted[i] == ".." {
                        if splitted[i-1] != ".." {
                            splitted.remove(at: i)
                            splitted.remove(at: i-1)
                            break
                        }
                    }
                }
             
                if i == splitted.count-1 {
                    keepLooping = false
                }
            }
        }
        
        return "\(absolutePath ? "/" : "")\(splitted.joined(separator: "/"))/"
    }
}
```

## Test

```swift
class Problem_222Tests: XCTestCase {

    func test_example() {
        let input = "/usr/bin/../bin/./scripts/../"
        let actual = input.shortestStandardizedPath()
        let expected = "/usr/bin/"
        
        XCTAssert(actual == expected)
    }

}
```