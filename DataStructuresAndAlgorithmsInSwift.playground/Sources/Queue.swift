import Foundation

public protocol Queue {
    associatedtype Element
    mutating func enqueue(_ element: Element) -> Bool
    mutating func dequeue() -> Element?
    var isEmpty: Bool { get }
    var peek: Element? { get }
}

// MARK: - QueueArray

public struct QueueArray<T>: Queue {
    private var array: [T] = []
    public init() {}
    
    public var isEmpty: Bool {
        return array.isEmpty
    }
    
    public var peek: T? {
        return array.first
    }
    
    @discardableResult
    public mutating func enqueue(_ element: T) -> Bool {
        array.append(element)
        return true
    }
    
    public mutating func dequeue() -> T? {
        return array.isEmpty ? nil : array.removeFirst()
    }
}

extension QueueArray: CustomStringConvertible {
    public var description: String {
        return array.description
    }
}

// MARK: - QueueDoublyLinkedLsit

public struct QueueLinkedList<T>: Queue {
    private var list = DoublyLinkedList<T>()
    public init() { }
    
    public mutating func enqueue(_ element: T) -> Bool {
        list.append(element)
        return true
    }
    
    public mutating func dequeue() -> T? {
        return list.isEmpty ? nil : list.pop()
    }
    
    public var peek: T? {
        return list.head?.value
    }
    
    public var isEmpty: Bool {
        return list.isEmpty
    }
}

extension QueueLinkedList: CustomStringConvertible {
    public var description: String {
        return list.description
    }
}
// MARK: - QueueDoubleStack

public struct QueueDoubleStack<T>: Queue {
    private var leftStack: [T] = []
    private var rightStack: [T] = []
    public init() { }
    
    public var isEmpty: Bool {
        return leftStack.isEmpty && rightStack.isEmpty
    }
    
    public var peek: T? {
        return !leftStack.isEmpty ? leftStack.last : rightStack.first
    }
    
    @discardableResult
    public mutating func enqueue(_ element: T) -> Bool {
        rightStack.append(element)
        return true
    }
    
    public mutating func dequeue() -> T? {
        if leftStack.isEmpty {
            leftStack = rightStack.reversed()
            rightStack.removeAll()
        }
        
        return leftStack.popLast()
    }
}
