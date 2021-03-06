## Description

This problem was asked by Google.

You are given a starting state start, a list of transition probabilities for a Markov chain, and a number of steps num_steps. Run the Markov chain starting from start for num_steps and compute the number of times we visited each state.

For example, given the starting state a, number of steps 5000, and the following transition probabilities:

```
[
  ('a', 'a', 0.9),
  ('a', 'b', 0.075),
  ('a', 'c', 0.025),
  ('b', 'a', 0.15),
  ('b', 'b', 0.8),
  ('b', 'c', 0.05),
  ('c', 'a', 0.25),
  ('c', 'b', 0.25),
  ('c', 'c', 0.5)
]
```

One instance of running this Markov chain might produce `{ 'a': 3012, 'b': 1656, 'c': 332 }`.
## Solution

```swift
import Foundation

typealias MarkovState = (from: String, to: String, probability: Double)

extension Array where Element == MarkovState {
    
    func compute(start: String, steps: Int) -> [String: Int] {
        var result: [String: Int] = [:]
        var current = start
        var iterations = steps
        
        while iterations > 0 {
            if let nextValue = next(from: current) {
                if result.keys.contains(nextValue) {
                    result[nextValue]! += 1
                } else {
                    result[nextValue] = 1
                }
                
                current = nextValue
                iterations -= 1
            }
        }
        
        return result
    }
    
    func next(from: String) -> String? {
        
        var filtered = self.filter{ $0.from == from }
        
        for i in 1..<filtered.count {
            filtered[i].probability += filtered[i-1].probability
        }
        
        let rand = Double.random(in: 0...1)
        
        for item in filtered {
            if rand <= item.probability {
                
                return item.to
            }
        }
        
        return nil
    }
}
```

## Test

```swift
class Problem_175Tests: XCTestCase {

    func test_example() {
        let input: [MarkovState] = [
          ("a", "a", 0.9),
          ("a", "b", 0.075),
          ("a", "c", 0.025),
          ("b", "a", 0.15),
          ("b", "b", 0.8),
          ("b", "c", 0.05),
          ("c", "a", 0.25),
          ("c", "b", 0.25),
          ("c", "c", 0.5)
        ]
        
        print(input.compute(start: "a", steps: 5000))
    }

}
```