import Foundation

extension Array where Element == Int {
    public mutating func bucketSort() {
        guard self.count > 0 else { return }
        let minValue = self.min() ?? 0
        let maxValue = self.max() ?? 0
        
        let bucketCount = self.count
        let range = maxValue - minValue + 1
        let bucketSize = Swift.max(1, range / bucketCount)
        var buckets: [[Int]] = .init(repeating: [], count: bucketCount)
        
        for value in self {
            var bucketIndex = (value - minValue) / bucketSize
            bucketIndex = Swift.min(bucketIndex, bucketCount - 1)
            buckets[bucketIndex].append(value)
        }
        
        self = buckets.flatMap { $0.sorted() }
    }
}
