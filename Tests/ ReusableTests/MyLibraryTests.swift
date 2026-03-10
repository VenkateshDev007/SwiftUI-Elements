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
}
