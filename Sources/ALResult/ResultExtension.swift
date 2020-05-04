//
//  File.swift
//  
//
//  Created by Alex Hmelevski on 2020-05-03.
//

import Foundation
    

extension Result {
    
    public init(_ success: Success) {
        self = .success(success)
    }
      
    public init(_ failure: Failure) {
        self = .failure(failure)
    }
    
    /// Performs side - effect closure on success
    ///
    /// Use this method when you need to perform side-effect function using
    /// the value of a `Result`  The following example prints value of
    /// the integer  on success:
    ///
    ///     func getNextInteger() -> Result<Int, Error> { /* ... */ }
    ///
    ///     let integerResult = getNextInteger()
    ///     // integerResult == .success(5)
    ///     let stringResult = integerResult.do({ debugPrint($0) }).map({ String($0) })
    ///     // console print: 5
    ///
    /// - Parameter work: A closure that takes the success value of this
    ///   instance.
    /// - Returns: An  unmodified`Result`
    @discardableResult
    public func `do`(_ work: (Success) -> Void) -> Self {
        if case .success(let val) = self {
            work(val)
        }
        return self
    }
    
    /// Performs side - effect closure on failure
    ///
    /// Use this method when you need to perform side-effect function using
    /// the value of a `Result`  The following example prints value of
    /// the integer  on success:
    ///
    ///     func getNextInteger() -> Result<Int, Error> { /* ... */ }
    ///
    ///     let integerResult = getNextInteger()
    ///     // integerResult == .error(NotFound)
    ///     let stringResult = integerResult.onError({ // notify about the error })
    ///     // console print: 5
    ///
    /// - Parameter work: A closure that takes the failure value of this
    ///   instance.
    /// - Returns: An  unmodified`Result`
    @discardableResult
    public func onError(_ work: (Failure) -> Void) -> Self {
        if case .failure(let err) = self {
            work(err)
        }
        return self
    }
}

extension Result where Failure == Error {
    
    public init(success: Success?, error: Failure?) {
        if let e = error {
            self = .failure(e)
            return
        }

        if let v = success {
            self = .success(v)
            return
        }

        let error = NSError(domain: "ALResult",
                            code: -1,
                            userInfo: ["msg": "Couldn't create monad out of 2 optionals"])
        self = .failure(error)
    }
    
  
    /// Returns a new result, mapping any success value using the given
    /// transformation.
    ///
    /// Use this method when you need to transform the value of a `Result`
    /// instance when it represents a success. The following example transforms
    /// the integer success value of a result into a string:
    ///
    ///     func getNextInteger() -> Result<Int, Error> { /* ... */ }
    ///
    ///     let integerResult = getNextInteger()
    ///     // integerResult == .success(5)
    ///     let stringResult = integerResult.map({ String($0) })
    ///     // stringResult == .success("5")
    ///
    /// - Parameter transform: A closure that takes the success value of this
    ///   instance.
    /// - Returns: A `Result` instance with the result of evaluating `transform`
    ///   as the new success value if this instance represents a success.
    /// - Note: transform can throw and convert result state into .failure
    public func tryMap<NewSuccess>(_ transform: (Success) throws  -> NewSuccess) -> Result<NewSuccess, Failure> {
  
        switch self {
        case let .success(val):
            do {
                return try .success(transform(val))
            } catch {
                return .failure(error)
            }
            
        case let .failure(err):
            return .failure(err)
        }
    }
    
    /// Returns a new result, mapping any success value using the given
    /// transformation and unwrapping the produced result.
    ///
    /// - Parameter transform: A closure that takes the success value of the
    ///   instance.
    /// - Returns: A `Result` instance with the result of evaluating `transform`
    ///   as the new failure value if this instance represents a failure.
    /// - Note: transform can throw and convert result state into .failure
    public func tryFlatMap<NewSuccess>(_ transform: (Success) throws -> Result<NewSuccess, Failure>) -> Result<NewSuccess, Failure> {
        switch self {
        case let .success(val):
            do {
                return try transform(val)
            } catch {
                return .failure(error)
            }
          
        case let .failure(err):
            return .failure(err)
        }
    }
    
  
}
