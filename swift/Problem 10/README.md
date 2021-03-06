### Description

This problem was asked by Apple.

Implement a job scheduler which takes in a function `f` and an integer `n`, and calls `f` after `n` milliseconds.

### Solution

```swift
struct Functions {
    func printExecuted() {
        NSLog("executed")
    }
}

func BackgroundJobScheduler(fun: @escaping () -> (), delay: Double) {
    DispatchQueue.global(qos: .background).async {
        let start = Date()
        NSLog("starting at \(start.description)")
        
        while true {
            if Date().timeIntervalSince(start) >= delay / 1000 {
                DispatchQueue.main.async {
                    fun()
                }
                break
            }
        }
    }
}

func JobScheduler(fun: @escaping () -> (), delay: Double) {
    let start = Date()
    NSLog("starting at \(start.description)")
    
    while true {
        if Date().timeIntervalSince(start) >= delay / 1000 {
            fun()
            break
        }
    }
}
```