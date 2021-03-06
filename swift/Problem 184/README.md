## Description

This problem was asked by Amazon.

Given `n` numbers, find the greatest common denominator between them.

For example, given the numbers `[42, 56, 14]`, return `14`.

## Solution

```swift
extension Array where Element == Int {
    
    func greatestCommonDenominator() -> Int {
        
        if count == 1 {
            return self[0]
        }
        
        guard let max = self.sorted().first else {
            return 0
        }
        
        for value in stride(from: max, to: -1, by: -1) {
            let modulos = self.map{ $0 % value }
            let reduced = modulos.reduce(0, +)
            
            if reduced == 0 {
                return value
            }
        }
        
        return 0
    }
}
```

## Test

```swift
class Problem_184Tests: XCTestCase {

    func test_example() {
        XCTAssert([42, 56, 14].greatestCommonDenominator() == 14)
    }

}
```