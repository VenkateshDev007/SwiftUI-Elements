//
//  ReusableDatePickerStyle.swift
//  SwiftUIElements
//
//  Created by Polepalli, Venkatesh on 25/03/26.
//

import SwiftUI

// MARK: - Style

public enum ReusableDatePickerStyle: Sendable {
    case compact
    case graphical
    case wheel
    case plain
}

// MARK: - Component

public struct ReusableDatePicker: View {
    
    public typealias Style = ReusableDatePickerStyle
    
    @Binding private var date: Date
    
    private let title: String
    private let style: Style
    private let displayedComponents: DatePickerComponents
    private let range: ClosedRange<Date>?
    private let tint: Color?
    private let isDisabled: Bool
    private let accessibilityId: String?
    
    // MARK: - Initializer
    
    public init(
        title: String,
        selection: Binding<Date>,
        displayedComponents: DatePickerComponents = [.date],
        style: Style = .compact,
        range: ClosedRange<Date>? = nil,
        tint: Color? = nil,
        isDisabled: Bool = false,
        accessibilityId: String? = nil
    ) {
        self.title = title
        self._date = selection
        self.displayedComponents = displayedComponents
        self.style = style
        self.range = range
        self.tint = tint
        self.isDisabled = isDisabled
        self.accessibilityId = accessibilityId
    }
    
    // MARK: - Body
    
    public var body: some View {
        Group {
            if let range {
                DatePicker(
                    title,
                    selection: $date,
                    in: range,
                    displayedComponents: displayedComponents
                )
            } else {
                DatePicker(
                    title,
                    selection: $date,
                    displayedComponents: displayedComponents
                )
            }
        }
        .applyReusableDatePickerStyle(style)
        .tint(tint)
        .disabled(isDisabled)
        .reusableAccessibilityIdentifier(accessibilityId)
    }
}

// MARK: - Style Extension

private extension View {
    
    @ViewBuilder
    func applyReusableDatePickerStyle(
        _ style: ReusableDatePickerStyle
    ) -> some View {
        switch style {
        case .compact:
            self.datePickerStyle(.compact)
            
        case .graphical:
            self.datePickerStyle(.graphical)
            
        case .wheel:
            self.datePickerStyle(.wheel)
            
        case .plain:
            self.datePickerStyle(.compact)
                .labelsHidden()
        }
    }
}
