import XCTest
import SwiftUI
@testable import SwiftElements

final class SwiftElementsTests: XCTestCase {
    @MainActor
    func testReusableButton_labelInit_buildsBody() {
        let sut = ReusableButton(style: .primary, accessibilityId: "label_button", action: {}) {
            Label("Continue", systemImage: "chevron.right")
        }
        _ = sut.body
    }

    @MainActor
    func testReusableImage_buildsBody() {
        let sut = ReusableImage(systemName: "star.fill", style: .template(foregroundColor: .yellow), size: .init(width: 24, height: 24), accessibilityId: "star_icon")
        _ = sut.body
    }

    @MainActor
    func testReusableTextField_buildsBody() {
        let text = Binding<String>(get: { "" }, set: { _ in })
        let sut = ReusableTextField(text: text, style: .roundedBorder, prompt: Text("Enter name"), accessibilityId: "name_field")
        _ = sut.body
    }

    @MainActor
    func testReusableSlider_buildsBody() {
        let value = Binding<Double>(get: { 0.5 }, set: { _ in })
        let sut = ReusableSlider(title: "Volume", value: value, in: 0...1, step: 0.1, accessibilityId: "volume_slider")
        _ = sut.body
    }

    @MainActor
    func testReusableToggle_buildsBody() {
        let isOn = Binding<Bool>(get: { true }, set: { _ in })
        let sut = ReusableToggle(title: "Enabled", isOn: isOn, accessibilityId: "enabled_toggle")
        _ = sut.body
    }
}
