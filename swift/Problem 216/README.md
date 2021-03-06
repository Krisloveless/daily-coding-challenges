## Description

This problem was asked by Facebook.

Given a number in Roman numeral format, convert it to decimal.

The values of Roman numerals are as follows:

```
{
    'M': 1000,
    'D': 500,
    'C': 100,
    'L': 50,
    'X': 10,
    'V': 5,
    'I': 1
}
```

In addition, note that the Roman numeral system uses subtractive notation for numbers such as `IV` and `XL`.

For the input `XIV`, for instance, you should return `14`.

## Solution

```swift
extension String {
    
    func romanToDecimal() -> Int {
        
        let romanEncoding: [Character: Int] = [
            "M": 1000,
            "D": 500,
            "C": 100,
            "L": 50,
            "X": 10,
            "V": 5,
            "I": 1
        ]
        
        let filtered = self.filter { !"MDCLXVI".contains($0) }
        
        guard filtered.isEmpty else {
            fatalError("Input invalid")
        }
        
        var result = 0
        var maxValue = 0
        
        for i in stride(from: count-1, through: 0, by: -1) {
            
            let character = Array(self)[i]
            guard let value = romanEncoding[character] else {
                fatalError("Could not decode \(character)")
            }
            
            maxValue = max(value, maxValue)
            result += value == maxValue ? value : -value
        }
        
        return result
    }
}
```

## Test

```swift
class Problem_216Tests: XCTestCase {

    func test_example() {
        let expected = 14
        let actual = "XIV".romanToDecimal()
        
        XCTAssert(actual == expected)
    }

}
```