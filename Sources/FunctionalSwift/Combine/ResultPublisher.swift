import Foundation
import Combine

public struct ResultPublisher<Success, Failure: Error>: Publisher {

    public typealias Output = Success
    
    public typealias Failure = Failure
    
    private let result: () -> Result<Success, Failure>
    
    public init(result: @escaping () -> Result<Success, Failure>) {
        self.result = result
    }
    
  
    
    public func receive<S>(subscriber: S) where S : Subscriber, Failure == S.Failure, Success == S.Input {
        Deferred {
            Future { completion in
                completion(result())
            }
        }.receive(subscriber: subscriber)
            
    }
   
}


public extension ResultPublisher where Failure == Error {
    init(result: @escaping () throws -> Success) {
        self.result = {
            do {
                return .success(try result())
            } catch {
                return .failure(error)
            }
        }
    }
}
