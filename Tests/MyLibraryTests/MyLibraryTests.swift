import XCTest
@testable import MyLibrary

final class MyLibraryTests: XCTestCase {
    @MainActor
    func testBasicButton_init_primary_buildsBody() {
        let sut = BasicButton(title: "Continue") {}
        _ = sut.body
    }

    @MainActor
    func testBasicButton_init_secondary_buildsBody() {
        let sut = BasicButton(title: "Cancel", style: .secondary) {}
        _ = sut.body
    }

    @MainActor
    func testBasicButton_accessibilityIdentifier_doesNotCrashWhenSet() {
        let sut = BasicButton(title: "Continue", accessibilityId: "continue_button") {}
        _ = sut.body
    }
}
