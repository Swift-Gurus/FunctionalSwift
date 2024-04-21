import Foundation
import SwiftUI
import Combine

public struct AsyncContentView<
    Source: LoadableObject,
    Content: View,
    ErrorView: View,
    ProgressView: View,
    Idle: View
>: View {
    @ObservedObject var source: Source
    @ViewBuilder var content: (Source.Output) -> Content
    @ViewBuilder var progressView: () -> ProgressView
    @ViewBuilder var errorView: (Error, VoidClosure) -> ErrorView
    @ViewBuilder var idle: () -> Idle
    public init(source: Source,
                @ViewBuilder content: @escaping (Source.Output) -> Content,
                @ViewBuilder progressView: @escaping () -> ProgressView,
                @ViewBuilder errorView: @escaping (Error, VoidClosure) -> ErrorView,
                @ViewBuilder idle: @escaping () -> Idle) {
        self.source = source
        self.content = content
        self.progressView = progressView
        self.errorView = errorView
        self.idle = idle
    }
    
    public var body: some View {
        switch source.state {
        case .idle:
            idle().onAppear(perform: source.load)
        case .loading:
            progressView()
        case .failed(let error):
            errorView(error, source.load)
        case .loaded(let output):
            content(output)
        }
    }
}


extension AsyncContentView {
    public init<P: Publisher>(
        sourcePublisher: P,
        @ViewBuilder content: @escaping (P.Output) -> Content,
        @ViewBuilder progressView: @escaping () -> ProgressView,
        @ViewBuilder errorView: @escaping (Error, VoidClosure) -> ErrorView,
        @ViewBuilder idle: @escaping () -> Idle)  where Source == PublishedObject<P> {
        self.init(
            source: PublishedObject(publisher: sourcePublisher),
            content: content,
            progressView: progressView,
            errorView: errorView,
            idle: idle
        )
    }
}


extension AsyncContentView where Idle == Color {
    public init<P: Publisher>(
        source: P,
        @ViewBuilder content: @escaping (P.Output) -> Content,
        @ViewBuilder progressView: @escaping () -> ProgressView,
        @ViewBuilder errorView: @escaping (Error, VoidClosure) -> ErrorView)  where Source == PublishedObject<P> {
        self.init(
            source: PublishedObject(publisher: source),
            content: content,
            progressView: progressView,
            errorView: errorView,
            idle: { Color.clear }
        )
    }
}
