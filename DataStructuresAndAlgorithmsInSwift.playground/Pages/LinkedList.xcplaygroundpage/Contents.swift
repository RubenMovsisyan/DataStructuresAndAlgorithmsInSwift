import UIKit

//MARK: - Node

func creatingAndLinkingNodes(){
    let node1 = Node(value: 1)
    let node2 = Node(value: 2)
    let node3 = Node(value: 3)
    node1.next = node2
    node2.next = node3
    
    print(node1)
}

//creatingAndLinkingNodes()

//MARK: - LinkedList

var list = LinkedList<Int>()

func pushingInLinkedList() {
    list.push(3)
    list.push(2)
    list.push(1)
    
    print(list)
}

//pushingInLinkedList()

func appendingInLinkedList() {
    list.append(1)
    list.append(2)
    list.append(3)
    
    print(list)
}

//appendingInLinkedList()

func insertingInLinkedList() {
    list.push(3)
    list.push(2)
    list.push(1)
    print("Before inserting: \(list)")
    
    var middleNode = list.node(at: 1)!
    
    for _ in 1...4 {
        middleNode = list.insert(-1, after: middleNode)
    }
    print("After inserting: \(list)")
}

//insertingInLinkedList()

func popingFromLinkedList() {
    list.push(1)
    list.push(2)
    list.push(3)
    
    print("Before popping list: \(list)")
    let poppedValue = list.pop()
    print("After popping list: \(list)")
    print("Popped value: " + String(describing: poppedValue))
}

//popingFromLinkedList()

func removeLastFromLinkedList() {
    list.push(1)
    list.push(2)
    list.push(3)
    
    print("Before removing last from list: \(list)")
    let poppedValue = list.removeLast()
    print("After removing last from list: \(list)")
    print("Popped value: " + String(describing: poppedValue))

}

//removeLastFromLinkedList()

func removeParticularNodeInLinkedList() {
    list.push(3)
    list.push(2)
    list.push(1)
    print("Before removing at particular index: \(list)")
    let index = 1
    let node = list.node(at: index - 1)!
    let removedValue = list.remove(after: node)
    print("After removing at index \(index): \(list)")
    print("Removed value: " + String(describing: removedValue))
}

//removeParticularNodeInLinkedList()

func usingCollectionInLinkedList() {
    for i in 0...9 {
        list.append(i)
    }
    print("List: \(list)")
    print("First element: \(list[list.startIndex])")
    print("Array containing first 3 elements: \(Array(list.prefix(3)))")
    print("Array containing last 3 elements: \(Array(list.suffix(3)))")
    let sum = list.reduce(0, +)
    
    print("Sum of all values: \(sum)")
}

//usingCollectionInLinkedList()


func linkedListCOW() {
    list.append(1)
    list.append(2)
    
    var list2 = list
    
    print(list)
    print(list2)
    
    print("After appending 3 to list2")
    list2.append(3)
    print(list)
    print(list2)
}

//linkedListCOW()

func initStackFromArray() {
    var stack: Stack = ["A", "B", "C", "D"]
    print(stack)
    stack.pop()
    stack.pop()
    print(stack)
}

//initStackFromArray()

func testQueueArray() {
    var queue = QueueArray<String>()
    
    queue.enqueue("Bob")
    queue.enqueue("John")
    queue.enqueue("Lisa")
    
    print(queue)
    print(queue.peek!)
    
    queue.dequeue()
    queue.dequeue()
    print(queue.isEmpty)
}

//testQueueArray()


var doublyLinkedList = DoublyLinkedList<Int>()

func pushingToDoublyLinkedList() {
    doublyLinkedList.push(4)
    doublyLinkedList.push(5)
    doublyLinkedList.push(6)
    print(doublyLinkedList)
    doublyLinkedList.pop()
    print(doublyLinkedList)
}

//pushingToDoublyLinkedList()


func testQueueLinkedLsit() {
    var queue = QueueLinkedList<String>()
    
    queue.enqueue("Bob")
    queue.enqueue("John")
    queue.enqueue("Lisa")
    
    print(queue)
    print(queue.peek!)
    
    queue.dequeue()
    queue.dequeue()
    print(queue.isEmpty)
}

//testQueueLinkedLsit()


func createATree() {
    let beverages = TreeNode("Beverage")
    let hot = TreeNode("Hot")
    let cold = TreeNode("Cold")
    
    beverages.add(hot)
    beverages.add(cold)
    print(beverages.children)
}

//createATree()


var tree: AVLNode<Int> {
    let zero = AVLNode(value: 0)
    let one = AVLNode(value: 1)
    let five = AVLNode(value: 5)
    let seven = AVLNode(value: 7)
    let eight = AVLNode(value: 8)
    let nine = AVLNode(value: 9)
    
    seven.leftChild = one
    one.leftChild = zero
    one.rightChild = five
    seven.rightChild = nine
    nine.leftChild = eight
    
    return seven
}

func treeDiagram() {
    print(tree)
}

//treeDiagram()

func traverseInOrder() {
    tree.traverseInOrder { print( $0 ) }
}

//traverseInOrder()

func traversePreOrder() {
    tree.traversePreOrder { print( $0 ) }
}

//traversePreOrder()

func traversePostOrder() {
    tree.traversePostOrder { print( $0 ) }
}

//traversePostOrder()

var exampleTree: AVLTree<Int> {
    var bst = AVLTree<Int>()
    bst.insert(3)
    bst.insert(1)
    bst.insert(4)
    bst.insert(0)
    bst.insert(2)
    bst.insert(5)
    return bst
}

//print(exampleTree)

func findANode() {
    if exampleTree.contains(5) {
        print("Found 5")
    } else {
        print("Couldn't find 5")
    }
}

//findANode()

func removeANode() {
    var tree = exampleTree
    print("Tree before removal:")
    print(tree)
    tree.remove(1)
    print("Tree after removing root:")
    print(tree)
}

//removeANode()

func repeatedInsertionInSequence() {
    var tree = AVLTree<Int>()
    for i in 0..<15 {
        tree.insert(i)
    }
    print(tree)
}

//repeatedInsertionInSequence()

func removingFromTree() {
    var tree = AVLTree<Int>()
    tree.insert(15)
    tree.insert(10)
    tree.insert(16)
    tree.insert(18)
    print(tree)
    tree.remove(10)
    print(tree)
}

//removingFromTree()


let rBTree = RedBlackTree<String, String>()
rBTree.insert(key: "hello", value: "world")

func trieExample () {
    let trie = Trie<String>()
    trie.insert("cut")
    trie.insert("cute")
    
    print("\n*** Before removing ***")
    assert(trie.contains("cut"))
    print("\"cut\" is in the trie")
    assert(trie.contains("cute"))
    print("\"cute\" is in the trie")
    
    print("\n*** After removing cut ***")
    trie.remove("cut")
    assert(!trie.contains("cut"))
    assert(trie.contains("cute"))
    print("\"cute\" is still in the trie")
}

//trieExample()

func triePrefixMatching() {
    let trie = Trie<String>()
    trie.insert("car")
    trie.insert("card")
    trie.insert("care")
    trie.insert("cared")
    trie.insert("cars")
    trie.insert("carbs")
    trie.insert("carapace")
    trie.insert("cargo")
    
    print("\nCollections starting with \"car\"")
    let prefixedWithCar = trie.collections(startingWith: "car")
    print(prefixedWithCar)
    
    print("\nCollections starting with \"care\"")
    let prefixedWithCare = trie.collections(startingWith: "care")
    print(prefixedWithCare)
}

//triePrefixMatching()

func binarySearchExample() {
    let arr = [1, 5, 15, 17, 19, 22, 24, 31, 105, 150]
    let search31 = arr.firstIndex(of: 31)
    let binarySearch31 = arr.binarySearch(for: 31)
    
    print("index(of:): \(String(describing: search31))")
    print("binarySearch(for:): \(String(describing: binarySearch31))")
}

//binarySearchExample()

func heapExample() {
    var heap = Heap(sort: <, elements: [1,12,3,4,15,1,6,8,7])
    
    while !heap.isEmpty {
        print(heap.remove()!)
    }
}

//heapExample()

func bubbleSortExample() {
    var arr = [8,4,10,3]
    print("Original: \(arr)")
    bubbleSort(&arr)
    print("Bubble Sorted: \(arr)")
}

//bubbleSortExample()


func selectionSortExample() {
    var arr = [8,4,10,3]
    print("Original: \(arr)")
    selectionSort(&arr)
    print("Selection Sorted: \(arr)")
}

//selectionSortExample()

func insertionSortExample() {
    var arr = [8,4,10,3]
    print("Original: \(arr)")
    insertionSort(&arr)
    print("Insertion Sorted: \(arr)")
}

//insertionSortExample()

func mergeSortExample() {
    var arr = [8,4,5,6,7,4,10,3]
    print("Original: \(arr)")
    print("Merge Sorted: \(mergeSort(arr))")
}

//mergeSortExample()

func quickSortExample() {
    var arr = [8,4,10,3]
    print("Original: \(arr)")
    print("Quick Sorted: \(quickSort(arr))")
}

//quickSortExample()


func radixSortExample() {
    var arr = [88,420,1770,30]
    print("Original: \(arr)")
    arr.radixSort()
    print("Radix Sorted: \(arr)")
}

//radixSortExample()

func bucketSortExample() {
    var arr = [42, -17, 0, 23, -8, 95, -100, 12, 56, 34]
    print("Original: \(arr)")
    arr.bucketSort()
    print("Bucket Sorted: \(arr)")
}

//bucketSortExample()

let heap = Heap(sort: >, elements: [6, 12, 2, 26, 8, 18, 21, 5, 9])
//print(heap.sorted())


func adjacencyListExample() {
    let graph = AdjacencyMatrix<String>()
    let singapore = graph.createVertex(data: "Singapore")
    let tokyo = graph.createVertex(data: "Tokyo")
    let hongKong = graph.createVertex(data: "Hong Kong")
    let detroit = graph.createVertex(data: "Detroit")
    let sanFrancisco = graph.createVertex(data: "San Francisco")
    let washingtonDC = graph.createVertex(data: "Washington DC")
    let austinTexas = graph.createVertex(data: "Austin Texas")
    let seattle = graph.createVertex(data: "Seattle")
    
    graph.add(.undirected, from: singapore, to: hongKong, weight: 300)
    graph.add(.undirected, from: singapore, to: tokyo, weight: 500)
    graph.add(.undirected, from: hongKong, to: tokyo, weight: 250)
    graph.add(.undirected, from: tokyo, to: detroit, weight: 450)
    graph.add(.undirected, from: tokyo, to: washingtonDC, weight: 300)
    graph.add(.undirected, from: hongKong, to: sanFrancisco, weight: 600)
    graph.add(.undirected, from: detroit, to: austinTexas, weight: 50)
    graph.add(.undirected, from: austinTexas, to: washingtonDC, weight: 292)
    graph.add(.undirected, from: sanFrancisco, to: washingtonDC, weight: 337)
    graph.add(.undirected, from: washingtonDC, to: seattle, weight: 277)
    graph.add(.undirected, from: sanFrancisco, to: seattle, weight: 218)
    graph.add(.undirected, from: austinTexas, to: sanFrancisco, weight: 297)
    
    print(graph.description)
    print(graph.weight(from: singapore, to: tokyo)!, "\n")
    print("San Francisco Outgoing Flights:")
    print("--------------------------------")
    for edge in graph.edges(from: sanFrancisco) {
        print("from: \(edge.source) to: \(edge.destination)")
    }
    
    let verticesBFS = graph.breadthFirstSearch(from: singapore)
    print("\n Graph in BFS")
    verticesBFS.forEach { vertex in
        print(vertex)
    }
    print("\n Graph in DFS")
    let verticesDFS = graph.depthFirstSearch(from: singapore)
    verticesDFS.forEach { vertex in
        print(vertex)
    }
}

adjacencyListExample()
