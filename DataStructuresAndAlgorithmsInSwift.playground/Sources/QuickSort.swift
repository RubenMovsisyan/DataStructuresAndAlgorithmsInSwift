import Foundation

public func quickSort<Element>(_ array: [Element]) -> [Element] where Element: Comparable {
    guard array.count > 1 else { return array }
    func quickSortHelper(_ array: inout [Element], low: Int, high: Int) {
        if low < high {
            let partitionIndex = partition(&array, low: low, high: high)
            quickSortHelper(&array, low: low, high: partitionIndex - 1)
            quickSortHelper(&array, low: partitionIndex + 1, high: high)
        }
    }
    
    func partition(_ array: inout [Element], low: Int, high: Int) -> Int {
        let pivot = array[high]
        var i = low - 1
        
        for j in low..<high {
            if array[j] <= pivot {
                i += 1
                array.swapAt(i, j)
            }
        }
        array.swapAt(i + 1, high)
        return i + 1
    }

    var mutableArray = array
    quickSortHelper(&mutableArray, low: 0, high: mutableArray.count - 1)
    return mutableArray
}

public func quicksortDutchFlag<T: Comparable>(_ array: inout [T], low: Int, high: Int) {
    if low < high {
        let (middleFirst, middleLast) = partisioningDutchFlag(&array, low: low, high: high)
        quicksortDutchFlag(&array, low: low, high: middleFirst - 1)
        quicksortDutchFlag(&array, low: middleLast + 1, high: high)
    }
}

private func partisioningDutchFlag<T: Comparable>(_ array: inout [T], low: Int, high: Int) -> (Int, Int) {
    var pivot = array[low]
    var smaller = low
    var equal = low + 1
    var larger = high
    
    while equal <= larger {
        if array[equal] < pivot {
            array.swapAt(equal, smaller)
            smaller += 1
            equal += 1
        } else if array[equal] > pivot {
            array.swapAt(equal, larger)
            larger -= 1
        } else {
            equal += 1
        }
    }
    return (smaller, larger)
}
