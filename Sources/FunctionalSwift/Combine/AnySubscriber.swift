import Foundation
import Combine

public extension AnySubscriber {
    init(demand: Subscribers.Demand = .unlimited,
         receiveValue: @escaping ((Input) -> Void),
         receiveCompletion: ((Subscribers.Completion<Failure>) -> Void)? = nil) {
        self = AnySubscriber(receiveSubscription: { $0.request(demand)},
                             receiveValue: { receiveValue($0); return demand },
                             receiveCompletion: receiveCompletion)
        
    }
}
