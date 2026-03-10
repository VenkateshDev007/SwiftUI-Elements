//
//  ReusableTextField.swift
//  SwiftElements
//
//  Created by Polepalli, Venkatesh on 10/03/26.
//

import SwiftUI

public struct ReusableTextField<Label: View>: View {
    public enum Style: Sendable, Hashable {
        case automatic
        case roundedBorder
        case plain
    }

    private let text: Binding<String>
    private let style: Style
    private let prompt: Text?
    private let accessibilityId: String?
    private let label: Label

    public init(
        title: String,
        text: Binding<String>,
        style: Style = .roundedBorder,
        prompt: String? = nil,
        accessibilityId: String? = nil
    ) where Label == Text {
        self.text = text
        self.style = style
        self.prompt = prompt.map(Text.init)
        self.accessibilityId = accessibilityId
        self.label = Text(title)
    }

    public init(
        text: Binding<String>,
        style: Style = .roundedBorder,
        prompt: Text? = nil,
        accessibilityId: String? = nil,
        @ViewBuilder label: () -> Label
    ) {
        self.text = text
        self.style = style
        self.prompt = prompt
        self.accessibilityId = accessibilityId
        self.label = label()
    }

    public var body: some View {
        content
            .reusableAccessibilityIdentifier(accessibilityId)
    }

    @ViewBuilder
    private var content: some View {
        let field = TextField(text: text, prompt: prompt) { label }

        switch style {
        case .automatic:
            field
                .textFieldStyle(.automatic)
        case .roundedBorder:
            field
                .textFieldStyle(.roundedBorder)
        case .plain:
            field
                .textFieldStyle(.plain)
        }
    }
}

