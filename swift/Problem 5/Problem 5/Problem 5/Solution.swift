//
//  Solution.swift
//  Problem 5
//
//  Created by sebastien FOCK CHOW THO on 2019-06-10.
//  Copyright © 2019 sebastien FOCK CHOW THO. All rights reserved.
//

import Foundation

struct Cons {
    var a: Int
    var b: Int
}

func car(_ cons: Cons) -> Int {
    return cons.a
}

func cdr(_ cons: Cons) -> Int {
    return cons.b
}
