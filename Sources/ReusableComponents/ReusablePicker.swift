//
//  SwiftUIView.swift
//  SwiftUIElements
//
//  Created by Polepalli, Venkatesh on 23/03/26.
//

import SwiftUI

public enum ReusablePickerStyle {
    case `default`
    case segmented
    case wheel
    case menu
}

public struct ReusablePicker<SelectionValue: Hashable, Content: View, Label: View>: View {

    public typealias Style = ReusablePickerStyle

    private let selection: Binding<SelectionValue>
    private let style: Style
    private let accessibilityId: String?
    private let content: Content
    private let label: Label

    // MARK: - Initializer (Custom Label)
    public init(
        selection: Binding<SelectionValue>,
        style: Style = .default,
        accessibilityId: String? = nil,
        @ViewBuilder content: () -> Content,
        @ViewBuilder label: () -> Label
    ) {
        self.selection = selection
        self.style = style
        self.accessibilityId = accessibilityId
        self.content = content()
        self.label = label()
    }

    // MARK: - Convenience Init (String Label)
    public init(
        title: String,
        selection: Binding<SelectionValue>,
        style: Style = .default,
        accessibilityId: String? = nil,
        @ViewBuilder content: () -> Content
    ) where Label == Text {
        self.selection = selection
        self.style = style
        self.accessibilityId = accessibilityId
        self.content = content()
        self.label = Text(title)
    }

    public var body: some View {
        Picker(selection: selection, label: label) {
            content
        }
        .applyReusablePickerStyle(style)
        .reusableAccessibilityIdentifier(accessibilityId)
    }
}

// MARK: - Style Applier
private extension View {
    @ViewBuilder
    func applyReusablePickerStyle(_ style: ReusablePickerStyle) -> some View {
        switch style {
        case .default:
            self.pickerStyle(.automatic)
        case .segmented:
            self.pickerStyle(.segmented)
        case .wheel:
            self.pickerStyle(.wheel)
        case .menu:
            self.pickerStyle(.menu)
        }
    }
}
