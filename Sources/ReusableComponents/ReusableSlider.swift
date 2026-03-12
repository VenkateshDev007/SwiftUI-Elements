//
//  ReusableSlider.swift
//  SwiftElements
//
//  Created by Polepalli, Venkatesh on 10/03/26.
//

import SwiftUI

public struct ReusableSlider<Label: View>: View {
    private let value: Binding<Double>
    private let range: ClosedRange<Double>
    private let step: Double?
    private let accessibilityId: String?
    private let label: Label

    public init(
        title: String,
        value: Binding<Double>,
        in range: ClosedRange<Double> = 0...1,
        step: Double? = nil,
        accessibilityId: String? = nil
    ) where Label == Text {
        self.value = value
        self.range = range
        self.step = step
        self.accessibilityId = accessibilityId
        self.label = Text(title)
    }

    public init(
        value: Binding<Double>,
        in range: ClosedRange<Double> = 0...1,
        step: Double? = nil,
        accessibilityId: String? = nil,
        @ViewBuilder label: () -> Label
    ) {
        self.value = value
        self.range = range
        self.step = step
        self.accessibilityId = accessibilityId
        self.label = label()
    }

    public var body: some View {
        content
            .reusableAccessibilityIdentifier(accessibilityId)
    }

    @ViewBuilder
    private var content: some View {
        if let step {
            Slider(value: value, in: range, step: step) { label }
        } else {
            Slider(value: value, in: range) { label }
        }
    }
}

