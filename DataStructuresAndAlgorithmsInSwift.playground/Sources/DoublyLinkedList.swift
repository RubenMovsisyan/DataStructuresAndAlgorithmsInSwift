import Foundation

public struct DoublyLinkedList<Value> {
    public var head: DoublyNode<Value>?
    public var tail: DoublyNode<Value>?
    
    public init() { }
    
    public var isEmpty: Bool {
        return head == nil
    }
    
    //    MARK: - Access
    
    public func node(at index: Int) -> DoublyNode<Value>? {
        var currentNode = head
        var currentIndex = 0
        
        while currentNode != nil, currentIndex < index {
            currentNode = currentNode!.next
            currentIndex += 1
        }
        
        return currentNode
    }
    
    //    MARK: - Insertion O(1)
    
    public mutating func push(_ value: Value) {
        copyNodes()
        
        let newNode = DoublyNode(value: value, next: head)
        head?.previous = newNode
        head = newNode
        
        if tail == nil {
            tail = head
        }
    }
    
    public mutating func append(_ value: Value) {
        copyNodes()
        
        guard !isEmpty else {
            push(value)
            return
        }
        let newNode = DoublyNode(value: value, previous: tail)
        tail!.next = newNode
        tail = newNode
    }
    
    @discardableResult
    public mutating func insert(_ value: Value, after node: DoublyNode<Value>) -> DoublyNode<Value> {
        copyNodes()
        
        guard tail !== node else {
            append(value)
            return tail!
        }
        
        let newNode = DoublyNode(value: value, previous: node, next: node.next)
        node.next?.previous = newNode
        node.next = newNode
        return newNode
    }
    
    //    MARK: - Deletion O(1)
    
    @discardableResult
    public mutating func pop() -> Value? {
        copyNodes()
        
        guard !isEmpty else { return nil }
        defer {
            head = head?.next
            head?.previous = nil
            if isEmpty {
                tail = nil
            }
        }
        return head?.value
    }
    
    @discardableResult
    public mutating func removeLast() -> Value? {
        copyNodes()
        
        guard let tail = tail else { return nil }
        
        defer {
            self.tail = tail.previous
            self.tail?.next = nil
            if isEmpty {
                head = nil
            }
        }
        return tail.value
    }
    
    @discardableResult
    public mutating func remove(after node: DoublyNode<Value>) -> Value? {
        copyNodes()
        
        guard let nextNode = node.next else { return nil}
        
        defer {
            node.next = nextNode.next
            nextNode.next?.previous = node
            
            if node.next === tail {
                tail = node
            }
        }
        return nextNode.value
    }
 
    private mutating func copyNodes() {
        guard !isKnownUniquelyReferenced(&head) else { return }
        guard var oldNode = head else { return }
        
        head = DoublyNode(value: oldNode.value)
        var newNode = head
        var prevNode: DoublyNode<Value>? = nil
        
        while let nextOldNode = oldNode.next {
            newNode!.next = DoublyNode(value: nextOldNode.value)
            newNode!.previous = prevNode
            prevNode = newNode
            newNode = newNode!.next
            oldNode = nextOldNode
        }
        
        tail = newNode
    }
}

//    MARK: - Extensions

extension DoublyLinkedList: CustomStringConvertible {
    public var description: String {
        guard let head = head else {
            return "Empty list"
        }
        return String(describing: head)
    }
}
