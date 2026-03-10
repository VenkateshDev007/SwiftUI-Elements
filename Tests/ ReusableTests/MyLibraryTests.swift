import XCTest
@testable import SwiftElements

final class SwiftElementsTests: XCTestCase {
    @MainActor
    func testReusableButton_init_primary_buildsBody() {
        let sut = ReusableButton(title: "Continue") {}
        _ = sut.body
    }

    @MainActor
    func testReusableButton_init_secondary_buildsBody() {
        let sut = ReusableButton(title: "Cancel", style: .secondary) {}
        _ = sut.body
    }

    @MainActor
    func testReusableButton_accessibilityIdentifier_doesNotCrashWhenSet() {
        let sut = ReusableButton(title: "Continue", accessibilityId: "continue_button") {}
        _ = sut.body
    }
}
