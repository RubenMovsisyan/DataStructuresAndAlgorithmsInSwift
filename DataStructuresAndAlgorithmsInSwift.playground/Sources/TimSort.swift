import Foundation

public func timSort<T:Comparable>(_ array: [T]) -> [T] {
    let n = array.count
    let minRun = calculateMinRun(n)
    var arrayCopy = array
    
    var runs = [[T]]()
    var i = 0
    while i < n {
        var runEnd = i + 1
        while runEnd < n && arrayCopy[runEnd - 1] <= arrayCopy[runEnd] {
            runEnd += 1
        }
        
        if runEnd - 1 < minRun && runEnd < n {
            runEnd = min(i + minRun, n)
            insertionSort(&arrayCopy, start: i, end: runEnd - 1)
        }
        
        runs.append(Array(arrayCopy[i..<runEnd]))
        i = runEnd
    }
    
    while runs.count > 1 {
        var mergedRuns = [[T]]()
        for j in stride(from: 0, to: runs.count, by: 2) {
            if j + 1 < runs.count {
                mergedRuns.append(merge(runs[j], runs[j + 1]))
            } else {
                mergedRuns.append(runs[j])
            }
        }
        runs = mergedRuns
    }
    
    return runs.first ?? []
}

private func calculateMinRun(_ n: Int) -> Int {
    var r = 0
    var size = n
    while size >= 64 {
        r |= (size & 1)
        size >>= 1
    }
    
    return size + r
}

private func insertionSort<T:Comparable>(_ array: inout [T], start: Int, end: Int) {
    for i in (start + 1)...end {
        let key = array[i]
        var j = i - 1
        while j >= start && array[j] > key {
            array[j + 1] = array[j]
            j -= 1
        }
        
        array[j + 1] = key
    }
}

