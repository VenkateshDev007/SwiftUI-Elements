//
//  SwiftUIView.swift
//  SwiftUIElements
//
//  Created by Polepalli, Venkatesh on 17/03/26.
//

import SwiftUI

// MARK: - State

public enum ReusableProgressState: Sendable {
    /// Activity indicator (spinner)
    case activityIndicator
    
    /// Determinate progress
    case progress(value: Double, total: Double = 1.0)
}

// MARK: - Style

public enum ReusableProgressStyle: Sendable {
    case linear
    case circular
    case circularProgress(lineWidth: CGFloat = 10) // <- configurable lineWidth
}

// MARK: - Custom Circular Style

public struct CustomCircularProgressViewStyle: ProgressViewStyle {
    
    private let color: Color
    private let lineWidth: CGFloat
    
    public init(color: Color = .blue, lineWidth: CGFloat = 10) {
        self.color = color
        self.lineWidth = lineWidth
    }
    
    public func makeBody(configuration: Configuration) -> some View {
        ZStack {
            // Background track
            Circle()
                .stroke(Color.gray.opacity(0.3), lineWidth: lineWidth)
            
            // Progress ring
            Circle()
                .trim(from: 0.0, to: CGFloat(configuration.fractionCompleted ?? 0))
                .stroke(color, lineWidth: lineWidth)
                .rotationEffect(.degrees(-90))
                .animation(.linear, value: configuration.fractionCompleted)
            
            // Percentage label
            Text(String(format: "%.0f%%", (configuration.fractionCompleted ?? 0) * 100))
                .font(.headline)
                .bold()
        }
    }
}

// MARK: - View

public struct ReusableProgressView<Label: View>: View {
    
    public typealias Style = ReusableProgressStyle
    public typealias State = ReusableProgressState
    
    private let state: State
    private let style: Style
    private let tint: Color?
    private let accessibilityId: String?
    private let label: Label?
    
    // MARK: - Initializers
    
    /// Without label
    public init(
        state: State,
        style: Style = .circular,
        tint: Color? = nil,
        accessibilityId: String? = nil
    ) where Label == EmptyView {
        self.state = state
        self.style = style
        self.tint = tint
        self.accessibilityId = accessibilityId
        self.label = nil
    }
    
    /// With text label
    public init(
        state: State,
        style: Style = .linear,
        tint: Color? = nil,
        accessibilityId: String? = nil,
        title: String
    ) where Label == Text {
        self.state = state
        self.style = style
        self.tint = tint
        self.accessibilityId = accessibilityId
        self.label = Text(title)
    }
    
    /// Custom label
    public init(
        state: State,
        style: Style = .linear,
        tint: Color? = nil,
        accessibilityId: String? = nil,
        @ViewBuilder label: () -> Label
    ) {
        self.state = state
        self.style = style
        self.tint = tint
        self.accessibilityId = accessibilityId
        self.label = label()
    }
    
    // MARK: - Body
    
    public var body: some View {
        progressContent
            .applyReusableProgressStyle(style: style, tint: tint)
            .reusableAccessibilityIdentifier(accessibilityId)
    }
}

// MARK: - Internal Rendering

private extension ReusableProgressView {
    
    @ViewBuilder
    var progressContent: some View {
        switch state {
        case .activityIndicator:
            ProgressView()
            
        case let .progress(value, total):
            ProgressView(value: value, total: total) {
                if let label = label {
                    label
                }
            }
        }
    }
}

// MARK: - Style Modifier

private extension View {
    
    @ViewBuilder
    func applyReusableProgressStyle(
        style: ReusableProgressStyle,
        tint: Color?
    ) -> some View {
        switch style {
        case .linear:
            self
                .progressViewStyle(.linear)
                .tint(tint)
            
        case .circular:
            self
                .progressViewStyle(.circular)
                .tint(tint)
            
        case let .circularProgress(lineWidth):
            self
                .progressViewStyle(
                    CustomCircularProgressViewStyle(color: tint ?? .blue, lineWidth: lineWidth)
                )
        }
    }
}
