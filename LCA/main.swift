import Foundation

public final class Queue<E> : Sequence {
    /// beginning of queue
    private var first: Node<E>? = nil
    /// end of queue
    private var last: Node<E>? = nil
    /// size of the queue
    private(set) var count: Int = 0
    
    /// helper linked list node class
    fileprivate class Node<E> {
        fileprivate var item: E
        fileprivate var next: Node<E>?
        fileprivate init(item: E, next: Node<E>? = nil) {
            self.item = item
            self.next = next
        }
    }
    
    /// Initializes an empty queue.
    public init() {}
    
    /// Returns true if this queue is empty.
    public func isEmpty() -> Bool {
        return first == nil
    }
    
    /// Returns the item least recently added to this queue.
    public func peek() -> E? {
        return first?.item
    }
    
    /// Adds the item to this queue
    /// - Parameter item: the item to add
    public func enqueue(item: E) {
        let oldLast = last
        last = Node<E>(item: item)
        if isEmpty() { first = last }
        else { oldLast?.next = last }
        count += 1
    }
    
    /// Removes and returns the item on this queue that was least recently added.
    public func dequeue() -> E? {
        if let item = first?.item {
            first = first?.next
            count -= 1
            // to avoid loitering
            if isEmpty() { last = nil }
            return item
        }
        return nil
    }
    
    /// QueueIterator that iterates over the items in FIFO order.
    public struct QueueIterator<E> : IteratorProtocol {
        private var current: Node<E>?
        
        fileprivate init(_ first: Node<E>?) {
            self.current = first
        }
        
        public mutating func next() -> E? {
            if let item = current?.item {
                current = current?.next
                return item
            }
            return nil
        }
        
        public typealias Element = E
    }
    
    /// Returns an iterator that iterates over the items in this Queue in FIFO order.
    public __consuming func makeIterator() -> QueueIterator<E> {
        return QueueIterator<E>(first)
    }
}

extension Queue: CustomStringConvertible {
    public var description: String {
        return self.reduce(into: "") { $0 += "\($1) " }
    }
}

struct Edge {}
class Graph {}
// ...

struct Set {
    let p: Int
    let q: Int
}

func solution() {
    // inputs
    let inputs = readInput()
    var adj = inputs.0
    let sets = inputs.1
    
    // mut update adj list
    mutConvertToUnidirect(node: 1, adj: &adj)

    // run to each inputs
    for set in sets {
        let r = dfs(root: 1, p: set.p, q: set.q, adj: adj)
        print(r!)
    }
}

private func mutConvertToUnidirect(node: Int, adj: inout [[Int]]) {
    for child in adj[node] {
        adj[child].removeAll(where: {$0 == node})
        mutConvertToUnidirect(node: child, adj: &adj)
    }
}

private func readInput() -> ([[Int]], [Set]) {
    let N = Int(readLine()!)!
    var adj = [[Int]](repeating: [], count: N + 1)
    for _ in 1..<N {
        let line = readLine()!.split(separator: " ").map { Int($0)! }
        let from = line[0];
        let to = line[1]
        adj[from].append(to)
        adj[to].append(from)
    }
    let M = Int(readLine()!)!
    var sets = [Set]()
    for _ in 1...M {
        let line = readLine()!.split(separator: " ").map { Int($0)! }
        sets.append(Set(p: line[0], q: line[1]))
    }
    return (adj, sets)
}

private func dfs(root: Int?, p: Int, q: Int, adj: [[Int]]) -> Int? {
    // base case
    if root == nil || root == p || root == q { return root }
    
    // recursive case
    let children = adj[root!].map { dfs(root: $0, p: p, q: q, adj: adj)}
    if children.allSatisfy({ $0 == nil }) { return nil }
    if children.filter({ $0 != nil }).count == 2 { return root }
    return children.first(where: { $0 != nil })!
}

// make sure you run the function (before you submit)
solution()
