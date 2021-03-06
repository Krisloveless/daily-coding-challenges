## Description

This problem was asked by Coursera.

Given a 2D board of characters and a word, find if the word exists in the grid.

The word can be constructed from letters of sequentially adjacent cell, where "adjacent" cells are those horizontally or vertically neighboring. The same letter cell may not be used more than once.

For example, given the following board:

```
[
  ['A','B','C','E'],
  ['S','F','C','S'],
  ['A','D','E','E']
]
```

* `exists(board, "ABCCED")` returns `true` 
* `exists(board, "SEE")` returns `true`
* `exists(board, "ABCB")` returns `false`.

## Solution

```swift
extension Array where Element == Array<Character> {
    
    typealias MatrixPos = (row: Int, column: Int)
    
    func exists(word: String) -> Bool {
        var candidates: [MatrixPos] = []
        
        var wordCopy = word
        let character = wordCopy.removeFirst()
        
        for i in 0..<self.count {
            for j in 0..<self[i].count {
                let item = self[i][j]
                
                if item == character {
                    candidates.append((row: i, column: j))
                }
            }
        }
        
        for candidate in candidates {
            if find(word: wordCopy, fromPosition: candidate) {
                return true
            }
        }
        
        return false
    }
    
    private func find(word: String, fromPosition position: MatrixPos) -> Bool {
        
        var result: [([[Character]], MatrixPos)] = []
        
        var wordCopy = word
        let character = wordCopy.removeFirst()
        
        if left(of: position) == character {
            var copy = self
            copy[position.row][position.column-1] = "*" // We use an asterisk as "not a character", this would break if the word to find included an asterisk
            result.append((copy, (row: position.row, column: position.column-1)))
        }
        
        if right(of: position) == character {
            var copy = self
            copy[position.row][position.column+1] = "*"
            result.append((copy, (row: position.row, column: position.column+1)))
        }
        
        if top(of: position) == character {
            var copy = self
            copy[position.row-1][position.column] = "*"
            result.append((copy, (row: position.row-1, column: position.column)))
        }
        
        if bottom(of: position) == character {
            var copy = self
            copy[position.row+1][position.column] = "*"
            result.append((copy, (row: position.row+1, column: position.column)))
        }
        
        if wordCopy.isEmpty {
            return !result.isEmpty
        }
        
        for item in result {
            if item.0.find(word: wordCopy, fromPosition: item.1) {
                return true
            }
        }
        
        return false
    }
    
    private func left(of position: MatrixPos) -> Character? {
        
        if position.column - 1 >= 0 {
            return self[position.row][position.column-1]
        }
        
        return nil
    }
    
    private func right(of position: MatrixPos) -> Character? {
        
        if position.column + 1 < self[position.row].count {
            return self[position.row][position.column+1]
        }
        
        return nil
    }
    
    private func top(of position: MatrixPos) -> Character? {
        
        if position.row - 1 >= 0 {
            return self[position.row-1][position.column]
        }
        
        return nil
    }
    
    private func bottom(of position: MatrixPos) -> Character? {
        
        if position.row + 1 < self.count {
            return self[position.row+1][position.column]
        }
        
        return nil
    }
}
```

## Test

```swift
class Problem_98Tests: XCTestCase {

    func test_example() {
        let matrix: [[Character]] = [
            ["A","B","C","E"],
            ["S","F","C","S"],
            ["A","D","E","E"]
        ]
        
        XCTAssertTrue(matrix.exists(word: "ABCCED"))
        XCTAssertTrue(matrix.exists(word: "SEE"))
        XCTAssertFalse(matrix.exists(word: "ABCB"))
    }

}
```