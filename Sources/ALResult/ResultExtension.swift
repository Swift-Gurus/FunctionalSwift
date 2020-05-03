//
//  File.swift
//  
//
//  Created by Alex Hmelevski on 2020-05-03.
//

import Foundation
    



extension Result {
    
    /// Side effect function on success
    /// - Parameter work: a closure to perform on success
    /// - Returns: Result without any changes
    @discardableResult
    
    public func `do`(_ work: (Success) -> Void) -> Self {
        if case .success(let val) = self {
            work(val)
        }
        return self
    }
    
    ///  Side effect function on failure
    /// - Parameter work: a closure to perform on failure
    /// - Returns: Result without any changes
    @discardableResult
    
    public func onError(_ work: (Failure) -> Void) -> Self {
        if case .failure(let err) = self {
            work(err)
        }
        return self
    }
}

extension Result where Failure == Error {
    
    public func `do`(work: (Success) throws -> Void) -> Self {
       do {
           if case .success(let val) = self {
              try work(val)
           }
           return self
       } catch {
           return .failure(error)
       }
    }
    
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
    
    public init(_ success: Success) {
         self = .success(success)
     }
    
    public init(_ failure: Failure) {
        self = .failure(failure)
    }
    
    public init(success: Success?, error: Failure?) {
          if let e = error {
              self = .failure(e)
              return
          }

          if let v = success {
              self = .success(v)
              return
          }
          self = .failure(NSError(domain: "ALResult", code: -1, userInfo: ["msg": "Couldn't create monad out of 2 optionals"]))
    }
}
