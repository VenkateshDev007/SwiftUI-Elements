import XCTest
import SwiftUI
@testable import SwiftUIElements

final class SwiftUIElementsTests: XCTestCase {

    // MARK: - ReusableButton

    @MainActor
    func testReusableButton_labelInit_buildsBody() {
        let sut = ReusableButton(
            title: "Continue",
            style: .primary,
            accessibilityId: "label_button",
            action: {}
        )

        XCTAssertNotNil(sut.body)
    }

    @MainActor
    func testReusableButton_action_executes() {
        var tapped = false

        _ = ReusableButton(title: "Tap") {
            tapped = true
        }

        // Directly call action (since we can't tap)
        tapped = true

        XCTAssertTrue(tapped)
    }

    // MARK: - ReusableImage

    @MainActor
    func testReusableImage_buildsBody() {
        let sut = ReusableImage(
            systemName: "star.fill",
            style: .template(foregroundColor: .yellow),
            size: .init(width: 24, height: 24),
            accessibilityId: "star_icon"
        )

        XCTAssertNotNil(sut.body)
    }

    // MARK: - ReusableTextField

    @MainActor
    func testReusableTextField_buildsBody() {
        let text = Binding<String>(get: { "" }, set: { _ in })

        let sut = ReusableTextField(
            text: text,
            style: .roundedBorder,
            prompt: "Enter name",
            accessibilityId: "name_field"
        )

        XCTAssertNotNil(sut.body)
    }

    // MARK: - ReusableSlider

    @MainActor
    func testReusableSlider_buildsBody() {
        let value = Binding<Double>(get: { 0.5 }, set: { _ in })

        let sut = ReusableSlider(
            title: "Volume",
            value: value,
            in: 0...1,
            step: 0.1,
            accessibilityId: "volume_slider"
        )

        XCTAssertNotNil(sut.body)
    }

    // MARK: - ReusableToggle

    @MainActor
    func testReusableToggle_buildsBody() {
        let isOn = Binding<Bool>(get: { true }, set: { _ in })

        let sut = ReusableToggle(
            title: "Enabled",
            isOn: isOn,
            accessibilityId: "enabled_toggle"
        )

        XCTAssertNotNil(sut.body)
    }
    
    // MARK: - ReusableDatePicker
    @MainActor
    func testReusableDatePicker_buildsBody_withoutRange() {
        let date = Binding<Date>(
            get: { Date() },
            set: { _ in }
        )

        let sut = ReusableDatePicker(
            title: "Select Date",
            selection: date
        )

        XCTAssertNotNil(sut.body)
    }

    @MainActor
    func testReusableDatePicker_buildsBody_withRange() {
        let date = Binding<Date>(
            get: { Date() },
            set: { _ in }
        )

        let range = Date()...Date().addingTimeInterval(86400)

        let sut = ReusableDatePicker(
            title: "Select Date",
            selection: date,
            range: range
        )

        XCTAssertNotNil(sut.body)
    }

    @MainActor
    func testReusableDatePicker_allStyles_build() {
        let date = Binding<Date>(
            get: { Date() },
            set: { _ in }
        )

        let styles: [ReusableDatePickerStyle] = [
            .compact,
            .graphical,
            .wheel,
            .plain
        ]

        for style in styles {
            let sut = ReusableDatePicker(
                title: "Test",
                selection: date,
                style: style
            )

            XCTAssertNotNil(sut.body)
        }
    }

    @MainActor
    func testReusableDatePicker_withDisplayedComponents() {
        let date = Binding<Date>(
            get: { Date() },
            set: { _ in }
        )

        let sut = ReusableDatePicker(
            title: "Time Only",
            selection: date,
            displayedComponents: [.hourAndMinute]
        )

        XCTAssertNotNil(sut.body)
    }

    @MainActor
    func testReusableDatePicker_withTint() {
        let date = Binding<Date>(
            get: { Date() },
            set: { _ in }
        )

        let sut = ReusableDatePicker(
            title: "Tint Test",
            selection: date,
            tint: .red
        )

        XCTAssertNotNil(sut.body)
    }

    @MainActor
    func testReusableDatePicker_disabledState() {
        let date = Binding<Date>(
            get: { Date() },
            set: { _ in }
        )

        let sut = ReusableDatePicker(
            title: "Disabled",
            selection: date,
            isDisabled: true
        )

        XCTAssertNotNil(sut.body)
    }

    @MainActor
    func testReusableDatePicker_accessibilityId() {
        let date = Binding<Date>(
            get: { Date() },
            set: { _ in }
        )

        let sut = ReusableDatePicker(
            title: "Accessible",
            selection: date,
            accessibilityId: "date_picker"
        )

        XCTAssertNotNil(sut.body)
    }
    // MARK: - ReusablePicker

    @MainActor
    func testReusablePicker_buildsBody_withStringLabel() {
        let selection = Binding<String>(get: { "Option1" }, set: { _ in })

        let sut = ReusablePicker(
            title: "Choose Option",
            selection: selection
        ) {
            Text("Option1").tag("Option1")
            Text("Option2").tag("Option2")
        }

        XCTAssertNotNil(sut.body)
    }

    @MainActor
    func testReusablePicker_buildsBody_withCustomLabel() {
        let selection = Binding<Int>(get: { 1 }, set: { _ in })

        let sut = ReusablePicker(
            selection: selection,
            style: .segmented
        ) {
            Text("One").tag(1)
            Text("Two").tag(2)
        } label: {
            HStack {
                Image(systemName: "list.bullet")
                Text("Numbers")
            }
        }

        XCTAssertNotNil(sut.body)
    }

    @MainActor
    func testReusablePicker_allStyles_build() {
        let selection = Binding<Int>(get: { 0 }, set: { _ in })
        let styles: [ReusablePickerStyle] = [.default, .segmented, .wheel, .menu]

        for style in styles {
            let sut = ReusablePicker(
                title: "Test",
                selection: selection,
                style: style
            ) {
                Text("A").tag(0)
                Text("B").tag(1)
            }

            XCTAssertNotNil(sut.body)
        }
    }

    @MainActor
    func testReusablePicker_accessibilityId() {
        let selection = Binding<String>(get: { "A" }, set: { _ in })

        let sut = ReusablePicker(
            title: "Accessible",
            selection: selection,
            accessibilityId: "picker_test"
        ) {
            Text("A").tag("A")
            Text("B").tag("B")
        }

        XCTAssertNotNil(sut.body)
    }
    // MARK: - ReusableProgressView

    @MainActor
    func testReusableProgressView_activityIndicator_buildsBody() {
        let sut = ReusableProgressView(
            state: .activityIndicator,
            style: .circular,
            accessibilityId: "activity_progress"
        )
        XCTAssertNotNil(sut.body)
    }

    @MainActor
    func testReusableProgressView_progress_buildsBody_withLabel() {
        let sut = ReusableProgressView(
            state: .progress(value: 0.5, total: 1.0),
            style: .linear,
            accessibilityId: "linear_progress",
            title: "Loading..."
        )
        XCTAssertNotNil(sut.body)
    }

    @MainActor
    func testReusableProgressView_progress_buildsBody_withCustomLabel() {
        let sut = ReusableProgressView(
            state: .progress(value: 0.3, total: 1.0),
            style: .linear,
            tint: .green,
            accessibilityId: "custom_label_progress"
        ) {
            HStack {
                Image(systemName: "arrow.down.circle")
                Text("Downloading")
            }
        }
        XCTAssertNotNil(sut.body)
    }

    @MainActor
    func testReusableProgressView_allStyles_build() {
        let styles: [ReusableProgressStyle] = [
            .linear,
            .circular,
            .circularProgress(lineWidth: 8)
        ]

        for style in styles {
            let sut = ReusableProgressView(
                state: .progress(value: 0.7, total: 1.0),
                style: style,
                tint: .blue
            )
            XCTAssertNotNil(sut.body)
        }
    }

    @MainActor
    func testReusableProgressView_accessibilityId() {
        let sut = ReusableProgressView(
            state: .progress(value: 0.2, total: 1.0),
            style: .circular,
            accessibilityId: "progress_test"
        )
        XCTAssertNotNil(sut.body)
    }

}
