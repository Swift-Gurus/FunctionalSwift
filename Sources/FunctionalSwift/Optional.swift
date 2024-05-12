import Foundation

infix operator »: transformOperator

precedencegroup transformOperator {
    associativity: left
}

public func »<T,U>(input: T, transform: (T) -> U) -> U {
    return transform(input)
}

public extension Optional {
    /// Conditional function, returns Either with valid value according to predicate block
    /// If predicate false - returns nil
    /// - Parameter predicate: (Wrapped) -> Bool
    /// - Returns: Wrapped?

    func filter(if predicate: (Wrapped) -> Bool) -> Wrapped? {
        switch self {
        case .some(let val):
            return predicate(val) ? self : nil

        case .none:
            return self
        }
    }

    /// Conditional check for Either returns current state if predicate true or default value
    ///
    /// - Parameters:
    ///   - predicate: (Wrapped) -> Bool
    ///   - default: Wrapped
    /// - Returns: Wrapped?

    func filter(default: Wrapped,
                if predicate: (Wrapped) -> Bool) -> Wrapped? {
        switch self {
        case .some(let val):
            return predicate(val) ? self : `default`

        case .none:
            return self
        }
    }

    /// Peform work on a chosen thread(asynchroniously) when a value is available
    ///
    /// - Parameters:
    ///   - queue: Queue where to perform the block
    ///   - work: block of work with value
    /// - Returns: unmodified Wrapped?
    @discardableResult
    func `do`(_ work: (Wrapped) -> Void) -> Wrapped? {
        if case .some(let val) = self {
            work(val)
        }
        return self
    }

    /// doNone function allows to perform some work if the result is none,
    ///
    /// - Parameter work: Block of work
    /// - Returns: Wrapped?
    @discardableResult
    func onNone(_ work: () -> Void) -> Wrapped? {
        if case .none = self {
            work()
        }
        return self
    }
}
