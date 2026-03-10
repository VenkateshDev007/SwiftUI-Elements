//
//  ReusableButton.swift
//  SwiftElements
//
//  Created by Polepalli, Venkatesh on 06/02/26.
//

import SwiftUI

public struct ReusableButton<Label: View>: View {
    public enum Style: Sendable {
        case primary
        case secondary
    }

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
        content
            .reusableAccessibilityIdentifier(accessibilityId)
    }

    @ViewBuilder
    private var content: some View {
        switch style {
        case .primary:
            Button(action: action) { label }
                .buttonStyle(.borderedProminent)
        case .secondary:
            Button(action: action) { label }
                .buttonStyle(.bordered)
        }
    }
}
