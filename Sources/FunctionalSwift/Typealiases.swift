// swiftlint:disable file_name

/// Convenience typealias where Failure == Error
public typealias ALResult<T> = Result<T, Error>

/// Convenience typealias for Closure<T> where T is ALResult<T>
public typealias ResultClosure<T> = Closure<ALResult<T>>

/// Convenience typealias for (T) -> Void
public typealias Closure<T> = (T) -> Void
