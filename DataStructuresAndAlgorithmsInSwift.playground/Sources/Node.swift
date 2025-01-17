import Foundation

//    MARK: - Node

public class Node<Value> {
    public var value: Value
    public var next: Node?
    
    public init(value: Value, next: Node? = nil) {
        self.value = value
        self.next = next
    }
}

extension Node: CustomStringConvertible {
    public var description: String {
        guard let next = next else { return "\(value)" }
        return "\(value) -> " + String(describing: next) + " "
    }
}

//    MARK: - DoublyNode

public class DoublyNode<Value> {
    public var value: Value
    public var previous: DoublyNode?
    public var next: DoublyNode?
    
    public init(value: Value, previous: DoublyNode? = nil, next: DoublyNode? = nil) {
        self.value = value
        self.previous = previous
        self.next = next
    }
}

extension DoublyNode: CustomStringConvertible {
    public var description: String {
        guard let next = next else { return "\(value)" }
        return "\(value) <-> " + String(describing: next) + " "
    }
}
