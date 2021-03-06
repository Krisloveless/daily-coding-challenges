## Description

This problem was asked by Jane Street.

Given an arithmetic expression in [Reverse Polish Notation](https://en.wikipedia.org/wiki/Reverse_Polish_notation), write a program to evaluate it.

The expression is given as a list of numbers and operands. For example: `[5, 3, '+']` should return `5 + 3 = 8`.

For example, `[15, 7, 1, 1, '+', '-', '/', 3, '*', 2, 1, 1, '+', '+', '-']` should return `5`, since it is equivalent to ((15 / (7 - (1 + 1))) * 3) - (2 + (1 + 1)) = 5.

You can assume the given expression is always valid.

## Solution

```swift
struct RPN {
    var input: [Any]
    
    func evaluate() -> Int {
        
        var operands: [Int] = []
        
        for element in input {
            if let intValue = element as? Int {
                operands.append(intValue)
            } else {
                guard let characterValue = element as? String else {
                    fatalError("Input must be strings (aka character) or ints")
                }
                
                if let rightOperand = operands.popLast(), let leftOperand = operands.popLast() {
                    operands.append(calculate(left: leftOperand, right: rightOperand, operation: Character(characterValue)))
                }
            }
        }
        
        return operands.last ?? 0
    }
    
    func calculate(left: Int, right: Int, operation: Character) -> Int {
        switch operation {
            case "+": return left + right
            case "-": return left - right
            case "*": return left * right
            case "/": return left / right
            default: return 0
        }
    }
}
```

## Test

```swift
class Problem_163Tests: XCTestCase {

    func test_example() {
        let rpn = RPN(input: [15, 7, 1, 1, "+", "-", "/", 3, "*", 2, 1, 1, "+", "+", "-"])
        print(rpn.evaluate())
    }

}
```