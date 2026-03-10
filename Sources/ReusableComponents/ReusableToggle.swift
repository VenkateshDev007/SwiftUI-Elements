//
//  ReusableToggle.swift
//  SwiftElements
//
//  Created by Polepalli, Venkatesh on 10/03/26.
//

import SwiftUI

public struct ReusableToggle<Label: View>: View {
    private let isOn: Binding<Bool>
    private let accessibilityId: String?
    private let label: Label

    public init(
        title: String,
        isOn: Binding<Bool>,
        accessibilityId: String? = nil
    ) where Label == Text {
        self.isOn = isOn
        self.accessibilityId = accessibilityId
        self.label = Text(title)
    }

    public init(
        isOn: Binding<Bool>,
        accessibilityId: String? = nil,
        @ViewBuilder label: () -> Label
    ) {
        self.isOn = isOn
        self.accessibilityId = accessibilityId
        self.label = label()
    }

    public var body: some View {
        Toggle(isOn: isOn) { label }
            .reusableAccessibilityIdentifier(accessibilityId)
    }
}

