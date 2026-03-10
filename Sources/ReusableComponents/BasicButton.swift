//
//  ReusableButton.swift
//
//  Created by Polepalli, Venkatesh on 06/02/26.
//

import SwiftUI

public struct ReusableButton: View {
    public enum Style: Sendable {
        case primary
        case secondary
    }

    private let title: String
    private let style: Style
    private let accessibilityId: String?
    private let action: () -> Void

    public init(
        title: String,
        style: Style = .primary,
        accessibilityId: String? = nil,
        action: @escaping () -> Void
    ) {
        self.title = title
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
            Button(title, action: action)
                .buttonStyle(.borderedProminent)
        case .secondary:
            Button(title, action: action)
                .buttonStyle(.bordered)
        }
    }
}

private extension View {
    @ViewBuilder
    func reusableAccessibilityIdentifier(_ id: String?) -> some View {
        if let id {
            accessibilityIdentifier(id)
        } else {
            self
        }
    }
}
