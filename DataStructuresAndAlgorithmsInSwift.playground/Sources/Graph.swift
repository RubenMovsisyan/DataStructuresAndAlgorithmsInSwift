import Foundation

public enum EdgeType {
    case directed, undirected
}

public protocol Graph {
    associatedtype Element
    
    func createVertex(data: Element) -> Vertex<Element>
    func addDirectedEdge(from source: Vertex<Element>,
                         to destination: Vertex<Element>,
                         weight: Double?)
    func addUndirectedEdge(between source: Vertex<Element>,
                           and destination: Vertex<Element>,
                           weight: Double?)
    func add(_ edge: EdgeType,
             from source: Vertex<Element>,
             to destination: Vertex<Element>,
             weight: Double?)
    func edges(from source: Vertex<Element>) -> [Edge<Element>]
    func weight(from source: Vertex<Element>,
                to destination: Vertex<Element>) -> Double?
    
}

extension Graph {
    public func addUndirectedEdge(between source: Vertex<Element>, and destination: Vertex<Element>, weight: Double?) {
        addDirectedEdge(from: source, to: destination, weight: weight)
        addDirectedEdge(from: destination, to: source, weight: weight)
    }
    
    public func add(_ edge: EdgeType, from source: Vertex<Element>, to destination: Vertex<Element>, weight: Double?) {
        switch edge {
        case .directed:
            addDirectedEdge(from: source, to: destination, weight: weight)
        case .undirected:
            addUndirectedEdge(between: source, and: destination, weight: weight)
        }
    }
}

extension Graph {
   public func breadthFirstSearch(from source: Vertex<Element>) -> [Vertex<Element>] {
        var queue = QueueDoubleStack<Vertex<Element>>()
        var enqueued: Set<Vertex<Element>> = []
        var visited: [Vertex<Element>] = []
        queue.enqueue(source)
        enqueued.insert(source)
        
        while let vertex = queue.dequeue() {
            visited.append(vertex)
            let neighborEdges = edges(from: vertex)
            neighborEdges.forEach { edge in
                if !enqueued.contains(edge.destination) {
                    queue.enqueue(edge.destination)
                    enqueued.insert(edge.destination)
                }
            }
        }
        
        return visited
    }
    
    public func depthFirstSearch(from source: Vertex<Element>) -> [Vertex<Element>] {
        var stack: Stack<Vertex<Element>> = []
        var pushed: Set<Vertex<Element>> = []
        var visited: [Vertex<Element>]  = []
        
        stack.push(source)
        pushed.insert(source)
        visited.append(source)
        
    outer: while let vertex = stack.peek() {
        let neighbors = edges(from: vertex)
        guard !neighbors.isEmpty else {
            stack.pop()
            continue
        }
        for edge in neighbors {
            if !pushed.contains(edge.destination) {
                stack.push(edge.destination)
                pushed.insert(edge.destination)
                visited.append(edge.destination)
                continue outer
            }
        }
        stack.pop()
    }
        
        return visited
    }
    
    public func depthFirstSearchRecursive(from source: Vertex<Element>) -> [Vertex<Element>] {
        var visited: [Vertex<Element>] = []
        var pushed: Set<Vertex<Element>> = []
        
        func dfs(from source: Vertex<Element>, visited: inout [Vertex<Element>], pushed: inout Set<Vertex<Element>>) {
            visited.append(source)
            pushed.insert(source)
            
            let neighbors = edges(from: source)
            
            for edge in neighbors {
                if !pushed.contains(edge.destination) {
                    dfs(from: edge.destination, visited: &visited, pushed: &pushed)
                }
            }
        }
        
        dfs(from: source, visited: &visited, pushed: &pushed)
        
        return visited
    }
}
