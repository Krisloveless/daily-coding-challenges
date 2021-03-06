## Description

This problem was asked by Affirm.

Given a array of numbers representing the stock prices of a company in chronological order, write a function that calculates the maximum profit you could have made from buying and selling that stock. You're also given a number fee that represents a transaction fee for each buy and sell transaction.

You must buy before you can sell the stock, but you can make as many transactions as you like.

For example, given [1, 3, 2, 8, 4, 10] and fee = 2, you should return 9, since you could buy the stock at 1 dollar, and sell at 8 dollars, and then buy it at 4 dollars and sell it at 10 dollars. Since we did two transactions, there is a 4 dollar fee, so we have 7 + 6 = 13 profit minus 4 dollars of fees.

## Solution

```swift
extension Array where Element == Int {
    
    typealias TransactionState = (holdingStock: Bool, profits: Int)
    
    func optimizeTransactions(withSellingFees: Int) -> Int {
        
        let initialState: TransactionState = (false, 0)
        let candidates = allTransactionPath(currentState: initialState, sellingFees: withSellingFees)
        let sorted = candidates.sorted{ $0.profits > $1.profits }
        
        return sorted.first?.profits ?? 0
    }
    
    func allTransactionPath(currentState: TransactionState, sellingFees: Int) -> [TransactionState] {
        
        var result: [TransactionState] = []
        
        if !currentState.holdingStock {
            
            result.append(currentState)
            
            for i in 0..<count {
                let state: TransactionState = (!currentState.holdingStock, currentState.profits-self[i])
                let futureTransactions = Array(suffix(count-i-1))
                result.append(contentsOf: futureTransactions.allTransactionPath(currentState: state, sellingFees: sellingFees))
            }
        } else {
            for i in 0..<count {
                let state: TransactionState = (!currentState.holdingStock, currentState.profits+self[i]-sellingFees)
                let futureTransactions = Array(suffix(count-i-1))
                result.append(contentsOf: futureTransactions.allTransactionPath(currentState: state, sellingFees: sellingFees))
            }
        }
        
        return result
    }
}
```

## Test

```swift
class Problem_193Tests: XCTestCase {

    func test_example() {
        XCTAssert([1, 3, 2, 8, 4, 10].optimizeTransactions(withSellingFees: 2) == 9)
    }

}
```