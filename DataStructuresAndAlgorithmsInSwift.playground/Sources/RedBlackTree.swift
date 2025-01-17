import Foundation

public class RedBlackTree<Key: Comparable, Value> {
    public private(set) var root: RBTreeNode<Key, Value>?
    
    public init() {}
    
    public func search(key: Key) -> RBTreeNode<Key, Value>? {
        var current = root
        while let node = current {
            if key < node.key {
                current = node.leftChild
            } else if key > node.key {
                current = node.rightChild
            } else {
                return node
            }
        }
        return nil
    }
    
    public func insert(key: Key, value: Value) {
        let newNode = RBTreeNode(key: key, value: value, color: .red)
        if root == nil {
            root = newNode
            root?.color = .black
        } else {
            insertHelper(root, newNode)
            fixInsertion(newNode)
        }
    }

    public func remove(_ key: Key) {
        guard let nodeToRemove = search(key: key) else { return }
        deleteNode(nodeToRemove)
    }
}

// MARK: - Insertion

private extension RedBlackTree {
    
    func insertHelper(_ current: RBTreeNode<Key, Value>?, _ newNode: RBTreeNode<Key, Value>) {
        guard let current = current else { return }
        if newNode.key < current.key {
            if let leftChild = current.leftChild {
                insertHelper(leftChild, newNode)
            } else {
                current.leftChild = newNode
                newNode.parent = current
            }
        } else {
            if let rightChild = current.rightChild {
                insertHelper(rightChild, newNode)
            } else {
                current.rightChild = newNode
                newNode.parent = current
            }
        }
    }
    
    func fixInsertion(_ node: RBTreeNode<Key, Value>) {
        var currentNode = node
        while let parent = currentNode.parent, parent.color == .red {
            let grandparent = parent.parent
            if parent === grandparent?.leftChild {
                let uncle = grandparent?.rightChild
                if uncle?.color == .red {
                    parent.color = .black
                    uncle?.color = .black
                    grandparent?.color = .red
                    currentNode = grandparent!
                } else {
                    if currentNode === parent.rightChild {
                        currentNode = parent
                        rotateLeft(currentNode)
                    }
                    parent.color = .black
                    grandparent?.color = .red
                    if let grandparent = grandparent {
                        rotateRight(grandparent)
                    }
                }
            } else {
                let uncle = grandparent?.leftChild
                if uncle?.color == .red {
                    parent.color = .black
                    uncle?.color = .black
                    grandparent?.color = .red
                    currentNode = grandparent!
                } else {
                    if currentNode === parent.leftChild {
                        currentNode = parent
                        rotateRight(currentNode)
                    }
                    parent.color = .black
                    grandparent?.color = .red
                    if let grandparent = grandparent {
                        rotateLeft(grandparent)
                    }
                }
            }
        }
        
        root?.color = .black
    }
    
    func rotateLeft(_ node: RBTreeNode<Key, Value>) {
        let pivot = node.rightChild
        node.rightChild = pivot?.leftChild
        pivot?.leftChild?.parent = node
        pivot?.parent = node.parent
        
        if node.parent == nil {
            root = pivot
        } else if node === node.parent?.leftChild {
            node.parent?.leftChild = pivot
        } else {
            node.parent?.rightChild = pivot
        }
        
        pivot?.leftChild = node
        node.parent = pivot
    }
    
    func rotateRight(_ node: RBTreeNode<Key, Value>) {
        let pivot = node.leftChild
        node.leftChild = pivot?.rightChild
        pivot?.rightChild?.parent = node
        pivot?.parent = node.parent
        
        if node.parent == nil {
            root = pivot
        } else if node === node.parent?.rightChild {
            node.parent?.rightChild = pivot
        } else {
            node.parent?.leftChild = pivot
        }
        
        pivot?.rightChild = node
        node.parent = pivot
    }
}

// MARK: - Deletion

private extension RedBlackTree {
    func deleteNode(_ node: RBTreeNode<Key, Value>) {
        var nodeToFix: RBTreeNode<Key, Value>?
        var isNodeToFixDoubleBlack = false
        
        if let successor = inOrderSuccessor(node) {
            node.key = successor.key
            node.value = successor.value
            deleteNode(successor)
            return
        }
        
        let replacement = node.leftChild ?? node.rightChild
        
        if let replacement = replacement {
            transplant(node, replacement)
            if node.color == .black {
                nodeToFix = replacement
                isNodeToFixDoubleBlack = true
            }
        } else {
            if node.color == .black {
                nodeToFix = node
                isNodeToFixDoubleBlack = true
            }
            transplant(node, nil)
        }
        
        if isNodeToFixDoubleBlack {
            fixDeletion(nodeToFix)
        }
    }
    
    func fixDeletion(_ node: RBTreeNode<Key, Value>?) {
        var current = node
        
        while current !== root, current?.color == .black {
            if current === current?.parent?.leftChild {
                let sibling = current?.parent?.rightChild
                
                if sibling?.color == .red {
                    sibling?.color = .black
                    current?.parent?.color = .red
                    rotateLeft(current!.parent!)
                }
                
                if (sibling?.leftChild?.color ?? .black) == .black &&
                    (sibling?.rightChild?.color ?? .black) == .black {
                    sibling?.color = .red
                    current = current?.parent
                } else {
                    if (sibling?.rightChild?.color ?? .black) == .black {
                        sibling?.leftChild?.color = .black
                        sibling?.color = .red
                        rotateRight(sibling!)
                    }
                    if let parentColor = current?.parent?.color {
                        sibling?.color = parentColor
                    }
                    current?.parent?.color = .black
                    sibling?.rightChild?.color = .black
                    rotateLeft(current!.parent!)
                    current = root
                }
            } else {
                let sibling = current?.parent?.leftChild
                
                if sibling?.color == .red  {
                    sibling?.color = .black
                    current?.parent?.color = .red
                    rotateRight(current!.parent!)
                }
                
                if (sibling?.leftChild?.color ?? .black) == .black &&
                    (sibling?.rightChild?.color ?? .black) == .black {
                    sibling?.color = .red
                    current = current?.parent
                } else {
                    if (sibling?.leftChild?.color ?? .black) == .black {
                        sibling?.rightChild?.color = .black
                        sibling?.color = .red
                        rotateLeft(sibling!)
                    }
                    if let parentColor = current?.parent?.color {
                        sibling?.color = parentColor
                    }
                    current?.parent?.color = .black
                    sibling?.leftChild?.color = .black
                    rotateRight(current!.parent!)
                    current = root
                }
            }
        }
        
        current?.color = .black
    }
    
    func transplant(_ u: RBTreeNode<Key, Value>, _ v: RBTreeNode<Key, Value>?) {
        if u.parent == nil {
            root = v
        } else if u === u.parent?.leftChild {
            u.parent?.leftChild = v
        } else {
            u.parent?.rightChild = v
        }
        v?.parent = u.parent
    }
    
    func inOrderSuccessor(_ node: RBTreeNode<Key, Value>) -> RBTreeNode<Key, Value>? {
        var current = node.rightChild
        while current?.leftChild != nil {
            current = current?.leftChild
        }
        return current
    }
}
