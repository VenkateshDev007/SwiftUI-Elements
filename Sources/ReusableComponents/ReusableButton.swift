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
        .applyReusableButtonStyle(
            buttonStyle: style
        )
        .reusableAccessibilityIdentifier(accessibilityId)
    }
}

private extension View {
    @ViewBuilder
    func applyReusableButtonStyle(
        buttonStyle: ReusableButtonStyle
    ) -> some View {
        switch buttonStyle {
        case .primary:
            self.buttonStyle(ReusablePrimaryButtonStyle())
        case .secondary:
            self.buttonStyle(ReusableSecondaryButtonStyle())
        case .destructive:
            self.buttonStyle(ReusableDestructiveButtonStyle())
        case .plain:
            self.buttonStyle(ReusablePlainButtonStyle())
        case .borderless:
            self.buttonStyle(ReusableBorderlessButtonStyle())
        }
    }
}

private struct ReusablePrimaryButtonStyle: PrimitiveButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        Button(action: configuration.trigger) {
            configuration.label
        }
        .buttonStyle(.borderedProminent)
    }
}

private struct ReusableSecondaryButtonStyle: PrimitiveButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        Button(action: configuration.trigger) {
            configuration.label
        }
        .buttonStyle(.bordered)
    }
}

private struct ReusableDestructiveButtonStyle: PrimitiveButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        Button(action: configuration.trigger) {
            configuration.label
        }
        .buttonStyle(.borderedProminent)
        .tint(.red)
    }
}

private struct ReusablePlainButtonStyle: PrimitiveButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        Button(action: configuration.trigger) {
            configuration.label
        }
        .buttonStyle(.plain)
    }
}

private struct ReusableBorderlessButtonStyle: PrimitiveButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        Button(action: configuration.trigger) {
            configuration.label
        }
        .buttonStyle(.borderless)
    }
}
