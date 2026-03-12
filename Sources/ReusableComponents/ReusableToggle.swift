//
//  ReusableToggle.swift
//  SwiftElements
//
//  Created by Polepalli, Venkatesh on 10/03/26.
//

import SwiftUI

public struct ReusableToggle: View {
    private let title: String
    private let isOn: Binding<Bool>
    private let accessibilityId: String?

    public init(
        title: String,
        isOn: Binding<Bool>,
        accessibilityId: String? = nil
    ) {
        self.title = title
        self.isOn = isOn
        self.accessibilityId = accessibilityId
    }

    public init(
        isOn: Binding<Bool>,
        accessibilityId: String? = nil
    ) {
        self.title = ""
        self.isOn = isOn
        self.accessibilityId = accessibilityId
    }

    public var body: some View {
        Toggle(title, isOn: isOn)
            .reusableAccessibilityIdentifier(accessibilityId)
    }
}

