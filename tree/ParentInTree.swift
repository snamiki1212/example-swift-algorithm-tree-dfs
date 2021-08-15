//
//  ParentInTree.swift
//  tree
//
//  Created by shunnamiki on 2021/08/12.
//

import Foundation


struct ParentInTree {
    static func main (){
        // get inputs to save adj list
        let n = Int(readLine()!)!
        var adj = [[Int]](repeating: [], count: n + 1)
        for _ in 0..<n-1 {
            let set = (readLine()!.split(separator: " ").map { Int($0)! })
            let n1 = set[0]
            let n2 = set[1]
            adj[n1].append(n2)
            adj[n2].append(n1)
        }
        
        var parents = [Int](repeating: -1, count: n + 1)
        var visited = [Bool](repeating: false, count: n + 1)

        // run
        dfs(from: 1, adj: &adj, visited: &visited, parents: &parents)

        // print
        for i in 2..<parents.count {
            print(parents[i])
        }
    }
    
    static func dfs(from: Int, adj: inout [[Int]], visited: inout [Bool], parents: inout [Int]){
        for to in adj[from] {
            if !visited[to] {
                visited[to] = true
                parents[to] = from
                dfs(from: to, adj: &adj, visited: &visited, parents: &parents)
            }
        }
    }
}
