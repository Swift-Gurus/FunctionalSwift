import Foundation

/// Default stride from 0 to End with increment by 1
/// - Parameter end: Int
/// - Returns: StrideTo<Int>
@inlinable
public func defaultIntStrideTo(_ end: Int) -> StrideTo<Int> {
    stride(from: 0, to: end, by: 1)
}
