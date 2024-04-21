import SwiftUI

public struct ErrorPopover: View {
    public let error: LocalizedError
    public init(error: Error) {
        self.error = ErrorWrapper(error: error)
    }
    
    public var body: some View {
        
            if #available(iOS 15.0, *) {
                placeholder.alert(title,
                                  isPresented: isPresent,
                                  actions: { EmptyView()},
                                  message: { message })
            } else {
                placeholder.alert(isPresented: isPresent, 
                                  content: {
                    .init(title: placeholder, message: message )
                })
            }
  
    }
    
    private var placeholder: Text {
        .init("")
    }
    
    private var isPresent: Binding<Bool> {
        .constant(true)
    }
    
    private var title: String {
        "Oops we have an error"
    }
    
    private var message: Text {
        Text("\(error.localizedDescription)")
    }
}

struct ErrorWrapper: LocalizedError {
    let error: Error
    var errorDescription: String?  {
        (error as? LocalizedError)?.localizedDescription ??
        "Error: \(error)"
    }
}

#Preview {
   
    return ErrorPopover(error: ErrorWrapper(error: NSError(domain: "domain", code: 1)))
}
