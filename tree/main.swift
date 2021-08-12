//
//  main.swift
//  tree
//
//  Created by shunnamiki on 2021/08/12.
//

import Foundation

// input
let n = Int(readLine()!)!
var list = [[Int]](repeating: [], count: n - 1)
for i in 0..<n-1 {
    list[i] = (readLine()!.split(separator: " ").map { Int($0)! })
}
var parent = [Int](repeating: -1, count: n + 1)

// run
parent[1] = 0
for set in list {
    let node1 = set[0]
    let node2 = set[1]
    if parent[node1] == -1{
        parent[node1] = node2
    } else {
        parent[node2] = node1
    }
}

// print
for i in 2..<parent.count {
    print(parent[i])
}

