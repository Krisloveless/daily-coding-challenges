## Description

This problem was asked by Apple.

Suppose you have a multiplication table that is N by N. That is, a 2D array where the value at the `i`-th row and `j`-th column is `(i + 1) * (j + 1)` (if 0-indexed) or `i * j` (if 1-indexed).

Given integers N and X, write a function that returns the number of times X appears as a value in an N by N multiplication table.

For example, given N = 6 and X = 12, you should return 4, since the multiplication table looks like this:

```
| 1 | 2 | 3 | 4 | 5 | 6 |

| 2 | 4 | 6 | 8 | 10 | 12 |

| 3 | 6 | 9 | 12 | 15 | 18 |

| 4 | 8 | 12 | 16 | 20 | 24 |

| 5 | 10 | 15 | 20 | 25 | 30 |

| 6 | 12 | 18 | 24 | 30 | 36 |
```

And there are 4 12's in the table.

## Solution

To check if the value V is in the column C, I would do 2 things:
 
- Check if V % C == 0
- If yes, check if V / C <= N (if it's greater, then it's not in the table)

I will apply this logic to a loop going through the columns.
    
```swift
struct MultiplicationTable {
    var length: Int
    
    func countOccurence(value: Int) -> Int {
        var count = 0
        
        for i in stride(from: length, to: 1, by: -1) {
            if value % i == 0 && value / i <= length {
                count += 1
            }
        }
        
        return count
    }
}
```

## Test

```swift
class Problem_74Tests: XCTestCase {

    func test_example() {
        let table = MultiplicationTable(length: 6)
        XCTAssert(table.countOccurence(value: 12) == 4)
    }

}

```