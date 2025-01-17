import Foundation

public enum NodeColor {
    case red, black
}

public class RBTreeNode<Key: Comparable, Value> {
    public var key: Key
    public var value: Value
    public var color: NodeColor
    public var leftChild: RBTreeNode?
    public var rightChild: RBTreeNode?
    public weak var parent: RBTreeNode?
    
    public init(key: Key, value: Value, color: NodeColor, parent: RBTreeNode? = nil) {
        self.key = key
        self.value = value
        self.color = color
        self.parent = parent
    }
}

