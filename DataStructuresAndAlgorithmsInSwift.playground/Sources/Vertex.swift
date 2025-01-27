import Foundation

public struct Vertex<T> {
    public let index: Int
    public let data: T
}

extension Vertex: Hashable {
    public func hash(into hasher: inout Hasher) {
            hasher.combine(index)
        }
    
    public static func ==(lhs: Vertex, rhs: Vertex) -> Bool {
        return lhs.index == rhs.index
    }
}

extension Vertex: CustomStringConvertible {
    public var description: String {
        return "\(index): \(data)"
    }
}
