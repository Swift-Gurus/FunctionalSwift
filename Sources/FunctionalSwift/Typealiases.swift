import Foundation
// swiftlint:disable file_name

/// Convenience typealias where Failure == Error
public typealias ALResult<T> = Result<T, Error>

/// Convenience typealias for Closure<T> where T is ALResult<T>
public typealias ResultClosure<T> = Closure<ALResult<T>>

/// Convenience typealias for (T) -> Void
public typealias Closure<T> = (T) -> Void

/// Convenience typealias for () -> Void
public typealias VoidClosure = () -> Void

/// Convenience type for ALResult<Void>.success(Void())
public let VoidSuccess = ALResult<Void>.success(Void())

/// Convenience type for creating unique id string
public let UUIDString = { UUID().uuidString }

