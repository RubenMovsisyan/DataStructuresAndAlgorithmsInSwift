import Foundation

public class AVLNode<Element> {
    public var value: Element
    public var leftChild: AVLNode?
    public var rightChild: AVLNode?
    public var height = 0
    
    public var balanceFactor: Int {
        return leftHeight - rightHeight
    }
    
    private var leftHeight: Int {
        return leftChild?.height ?? -1
    }
    
    private var rightHeight: Int {
        return rightChild?.height ?? -1
    }
    
    public init(value: Element) {
        self.value = value
    }
    
    public func updateHeight() {
        height = max(leftHeight, rightHeight) + 1
    }
}

extension AVLNode {
    public func traverseInOrder(visit: (Element)-> Void) {
        leftChild?.traverseInOrder(visit: visit)
        visit(value)
        rightChild?.traverseInOrder(visit: visit)
    }
    
    public func traversePreOrder(visit: (Element)-> Void) {
        visit(value)
        leftChild?.traversePreOrder(visit: visit)
        rightChild?.traversePreOrder(visit: visit)
    }
    
    public func traversePostOrder(visit: (Element)-> Void) {
        leftChild?.traversePostOrder(visit: visit)
        rightChild?.traversePostOrder(visit: visit)
        visit(value)
    }
}

extension AVLNode: CustomStringConvertible {
    public var description: String {
        return diagram(for: self)
    }
    
    private func diagram(for node: AVLNode?,
                         _ top: String = "",
                         _ root: String = "",
                         _ bottom: String = "") -> String {
        guard let node = node else {
            return root + "nil\n"
        }
        if node.leftChild == nil && node.rightChild == nil {
            return root + "\(node.value)\n"
        }
        return diagram(for: node.rightChild,
                       top + " ", top + "┌──", top + "│ ")
        + root + "\(node.value)\n"
        + diagram(for: node.leftChild,
                  bottom + "│ ", bottom + "└──", bottom + " ")
    }
}
