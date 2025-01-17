import Foundation

public struct PriorityQueue<Element: Equatable>: Queue {
    private var heap: Heap<Element>
    
    init(sort: @escaping(Element, Element) -> Bool, elements: [Element] = []) {
        self.heap = Heap(sort: sort, elements: elements)
    }
    
    public var isEmpty: Bool {
        return heap.isEmpty
    }
    
    public var peek: Element? {
        return heap.peek()
    }
    
    public mutating func enqueue(_ element: Element) -> Bool {
        heap.insert(element)
        return true
    }
    
    public mutating func dequeue() -> Element? {
       return heap.remove()
    }
}
