//
//  Diameter.swift
//  tree
//
//  Created by shunnamiki on 2021/08/14.
//

import Foundation

struct Diameter {

    struct Set {
        let to: Int
        let weight: Int
    }

    static func main(){
        // get inputs and create adj list
        let v = Int(readLine()!)!
        var adj = [[Set]](repeating: [], count: v + 1)
        for i in 1...v {
            let line = readLine()!.split(separator: " ").map { Int($0)! }
            var j = 1
            while(line.count > 2){
                let Vn = line[j]
                let Dn = line[j+1]
                adj[i].append(Set(to: Vn, weight: Dn))
                j += 2
                if line[j] == -1 { break }
            }
        }

        var visited = [Bool](repeating: false, count: v + 1)
        var weights = [Int](repeating: 0, count: v + 1)
        
        // get weights from node1 to all node
        mutWeights(node: 1, visited: &visited, adjList: adj, weights: &weights)

        // get leaf which is included in max path.
        var leaf = 0
        for node in 2..<weights.count {
            if weights[node] > weights[leaf] {
                leaf = node
            }
        }

        var visited2 = [Bool](repeating: false, count: v + 1)
        var weights2 = [Int](repeating: 0, count: v + 1)
        
        // get weights from above leaf to all node
        mutWeights(node: leaf, visited: &visited2, adjList: adj, weights: &weights2)

        // get max weight
        let r = weights.max()!
        print(r)
    }


    static func mutWeights(node: Int, visited: inout [Bool], adjList: [[Set]], weights: inout [Int]) {
        let q = Queue<Int>()
        q.enqueue(item: node)
        
        while !q.isEmpty() {
            let from = q.dequeue()!
            for set in adjList[from] {
                let to = set.to
                let weight = set.weight
                if !visited[to] {
                    visited[to] = true
                    weights[to] = weights[from] + weight
                    q.enqueue(item: to)
                }
            }
        }
    }

}
