//
//  ReusableTextField.swift
//  SwiftElements
//
//  Created by Polepalli, Venkatesh on 10/03/26.
//

import SwiftUI

public enum Style: Hashable, Sendable {
    case automatic
    case roundedBorder
    case plain
    case searchBar
    case secure
}

public struct ReusableTextField<ClearButtonView: View>: View {
    private let title: String
    private let text: Binding<String>
    private let style: Style
    private let prompt: Text?
    private let accessibilityId: String?
    private let clearButton: () -> ClearButtonView

    public init(
        title: String = "",
        text: Binding<String>,
        style: Style = .roundedBorder,
        prompt: String? = nil,
        accessibilityId: String? = nil,
        @ViewBuilder clearButton: @escaping () -> ClearButtonView = { EmptyView() }
    ) {
        self.title = title
        self.text = text
        self.style = style
        self.prompt = prompt.map(Text.init)
        self.accessibilityId = accessibilityId
        self.clearButton = clearButton
    }

    public var body: some View {
        content
            .reusableAccessibilityIdentifier(accessibilityId)
    }

    @ViewBuilder
    private var content: some View {
        switch style {
        case .automatic:
            TextField(title, text: text, prompt: prompt)
                .textFieldStyle(.automatic)

        case .roundedBorder:
            TextField(title, text: text, prompt: prompt)
                .textFieldStyle(.roundedBorder)

        case .plain:
            TextField(title, text: text, prompt: prompt)
                .textFieldStyle(.plain)

        case .searchBar:
            HStack(spacing: 8) {

                Image(systemName: "magnifyingglass")

                TextField(title, text: text, prompt: prompt)
                    .padding(.vertical, 6)

                if !text.wrappedValue.isEmpty {
                    Button {
                        text.wrappedValue = ""
                    } label: {
                        clearButton()
                    }
                }
            }
            .padding(.horizontal, 8)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.gray)
            )
            
        case .secure:
             SecureField(title, text: text, prompt: prompt)
                 .textFieldStyle(.roundedBorder)
         }
    }
}
