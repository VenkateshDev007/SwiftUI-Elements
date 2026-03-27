//
//  ReusableToggle.swift
//  SwiftElements
//
//  Created by Polepalli, Venkatesh on 10/03/26.
//

import SwiftUI

// MARK: - Toggle Styles Enum

public enum ReusableToggleStyleType: Sendable {
    case `default`
    case switchStyle
    case checkbox
    case buttonToggle
}

// MARK: - Reusable Toggle

public struct ReusableToggle: View {
    
    private let title: String
    private let isOn: Binding<Bool>
    private let accessibilityId: String?
    private let style: ReusableToggleStyleType
    private let tintColor: Color?
    
    // MARK: - Initializers
    
    public init(
        title: String,
        isOn: Binding<Bool>,
        accessibilityId: String? = nil,
        style: ReusableToggleStyleType = .default,
        tintColor: Color? = nil
    ) {
        self.title = title
        self.isOn = isOn
        self.accessibilityId = accessibilityId
        self.style = style
        self.tintColor = tintColor
    }
    
    public init(
        isOn: Binding<Bool>,
        accessibilityId: String? = nil,
        style: ReusableToggleStyleType = .default,
        tintColor: Color? = nil
    ) {
        self.title = ""
        self.isOn = isOn
        self.accessibilityId = accessibilityId
        self.style = style
        self.tintColor = tintColor
    }
    
    // MARK: - Body
    
    public var body: some View {
        Toggle(title, isOn: isOn)
            .modifier(ReusableToggleStyleModifier(style: style, tintColor: tintColor))
            .reusableAccessibilityIdentifier(accessibilityId)
    }
}

// MARK: - Toggle Style Modifier

struct ReusableToggleStyleModifier: ViewModifier {
    
    let style: ReusableToggleStyleType
    let tintColor: Color?
    
    func body(content: Content) -> some View {
        switch style {
        case .default:
            content.toggleStyle(DefaultToggleStyle())
            
        case .switchStyle:
            content.toggleStyle(SwitchToggleStyle(tint: tintColor ?? .blue))
            
        case .checkbox:
            content.toggleStyle(CheckToggleStyle()) // custom checkbox style
            
        case .buttonToggle:
            content.toggleStyle(.button)
        }
    }
}

// MARK: - Custom Checkbox Toggle Style

public struct CheckToggleStyle: ToggleStyle {
    public func makeBody(configuration: Configuration) -> some View {
        Button {
            configuration.isOn.toggle()
        } label: {
            Label {
                configuration.label
            } icon: {
                Image(systemName: configuration.isOn ? "checkmark.circle.fill" : "circle")
                    .foregroundStyle(configuration.isOn ? Color.accentColor : .secondary)
                    .accessibility(label: Text(configuration.isOn ? "Checked" : "Unchecked"))
                    .imageScale(.large)
            }
        }
        .buttonStyle(.plain)
    }
}
