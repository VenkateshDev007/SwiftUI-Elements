//
//  ReusableButton.swift
//  SwiftElements
//
//  Created by Polepalli, Venkatesh on 06/02/26.
//

import SwiftUI

public enum ReusableButtonStyle: Sendable {
    /// Prominent filled button (borderedProminent)
    case primary
    /// Standard bordered button
    case secondary
    /// Destructive, prominent style for destructive actions
    case destructive
    /// Plain button style (no chrome)
    case plain
    /// Borderless style (e.g. for toolbar-style actions)
    case borderless
}

public struct ReusableButton<Label: View>: View {
    public typealias Style = ReusableButtonStyle

    private let label: Label
    private let style: Style
    private let accessibilityId: String?
    private let action: () -> Void

    public init(
        title: String,
        style: Style = .primary,
        accessibilityId: String? = nil,
        action: @escaping () -> Void
    ) where Label == Text {
        self.label = Text(title)
        self.style = style
        self.accessibilityId = accessibilityId
        self.action = action
    }

    public init(
        style: Style = .primary,
        accessibilityId: String? = nil,
        action: @escaping () -> Void,
        @ViewBuilder label: () -> Label
    ) {
        self.label = label()
        self.style = style
        self.accessibilityId = accessibilityId
        self.action = action
    }

    public var body: some View {
        Button {
            action()
        } label: {
            label
        }
        .modifier(ReusableButtonStyleModifier(style: style))
        .reusableAccessibilityIdentifier(accessibilityId)
    }
}

// MARK: - Button Style Modifier
struct ReusableButtonStyleModifier: ViewModifier {
    
    let style: ReusableButtonStyle
    
    func body(content: Content) -> some View {
        switch style {
        case .primary:
            content.buttonStyle(.borderedProminent)
            
        case .secondary:
            content.buttonStyle(.bordered)
            
        case .destructive:
            content
                .buttonStyle(.borderedProminent)
                .tint(.red)
            
        case .plain:
            content.buttonStyle(.plain)
            
        case .borderless:
            content.buttonStyle(.borderless)
        }
    }
}
