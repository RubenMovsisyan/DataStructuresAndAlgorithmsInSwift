import Foundation

public struct AVLTree<Element: Comparable> {
    public private(set) var root: AVLNode<Element>?
    
    public init() {}

    public mutating func insert(_ value: Element) {
        root = insert(from: root, value: value)
    }
    
    private func insert(from node: AVLNode<Element>?, value: Element) -> AVLNode<Element> {
        guard let node = node else {
            return AVLNode(value: value)
        }
        
        if value < node.value {
            node.leftChild = insert(from: node.leftChild, value: value)
        } else {
            node.rightChild = insert(from: node.rightChild, value: value)
        }
        
        return balanced(node)
    }
    
    public func contains(_ value: Element) -> Bool {
        var current = root
        while let node = current {
            if node.value == value {
                return true
            }
            if value < node.value {
                current = node.leftChild
            } else {
                current = node.rightChild
            }
        }
        return false
    }
    
    public mutating func remove(_ value: Element) {
       root = remove(node: root, value: value)
    }
    
    private func remove(node: AVLNode<Element>?, value: Element) -> AVLNode<Element>? {
        guard let node = node else { return nil }
        
        if value == node.value {
            if node.leftChild == nil, node.rightChild == nil {
                return nil
            }
            if node.leftChild == nil {
                return node.rightChild
            }
            if node.rightChild == nil {
                return node.leftChild
            }
            node.value = node.rightChild!.min.value
            node.rightChild = remove(node: node.rightChild, value: node.value)
            
        } else if value < node.value {
            node.leftChild = remove(node: node.leftChild, value: value)
        } else {
            node.rightChild = remove(node: node.rightChild, value: value)
        }
    
        return balanced(node)
    }
    
    private func balanced(_ node: AVLNode<Element>) -> AVLNode<Element> {
        node.updateHeight()
        switch node.balanceFactor {
        case 2:
            if let leftChild = node.leftChild, leftChild.balanceFactor < 0 {
                return leftRightRotate(node)
            } else {
                return rightRotate(node)
            }
        case -2 :
            if let rightChild = node.rightChild, rightChild.balanceFactor > 0 {
                return rightLeftRotate(node)
            } else {
                return leftRotate(node)
            }
        default:
            return node
        }
    }

    private func leftRotate(_ node: AVLNode<Element>) -> AVLNode<Element> {
        guard let pivot = node.rightChild else { return node }
        node.rightChild = pivot.leftChild
        pivot.leftChild = node
        
        node.updateHeight()
        pivot.updateHeight()
        
        return pivot
    }
    
    private func rightRotate(_ node: AVLNode<Element>) -> AVLNode<Element> {
        guard let pivot = node.leftChild else { return node }
        node.leftChild = pivot.rightChild
        pivot.rightChild = node
        
        node.updateHeight()
        pivot.updateHeight()
        return pivot
    }
    
    private func rightLeftRotate(_ node: AVLNode<Element>) -> AVLNode<Element> {
        guard let rightChild = node.rightChild else { return node }
        node.rightChild = rightRotate(rightChild)
        return leftRotate(node)
    }
    
    private func leftRightRotate(_ node: AVLNode<Element>) -> AVLNode<Element> {
        guard let leftChild = node.leftChild else {  return node }
        node.leftChild = leftRotate(leftChild)
        return rightRotate(node)
    }
}

private extension AVLNode {
    var min: AVLNode {
        return leftChild?.min ?? self
    }
}

extension AVLTree: CustomStringConvertible {
    public var description: String {
    return root?.description ?? "empty tree"
    }
}
