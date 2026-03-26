[README.md](https://github.com/user-attachments/files/25839781/README.md)
## SwiftUIElements

`SwiftUIElements` is a lightweight, reusable SwiftUI component library that helps you build consistent UI faster. It provides configurable components like Button, Image, TextField, Slider, Toggle, Picker, DatePicker, and ProgressView.

Supports **iOS 15+** and **macOS 12+**.

---

## Features

* **`ReusableButton`**

  * Multiple styles: `.primary`, `.secondary`, `.destructive`, `.plain`, `.borderless`
  * Custom label support
  * Accessibility identifier

* **`ReusableImage`**

  * Supports SF Symbols, asset images, and remote images
  * Template styling (tint)
  * Resizable with aspect control

* **`ReusableTextField`**

  * Binding-based input
  * Multiple styles (`.roundedBorder`, `.plain`, `.automatic`)
  * Optional prompt

* **`ReusableSlider`**

  * Configurable range and step
  * Binding-based value

* **`ReusableToggle`**

  * Binding-based toggle
  * Simple and clean API

* **`ReusablePicker`**

  * Generic, type-safe picker
  * Styles:

    * `.automatic`
    * `.segmented`
    * `.wheel`
    * `.menu`
  * Supports:

    * String label
    * Custom label
    * Label-less usage
  * Accessibility support

* **`ReusableDatePicker`**

  * Supports date and time selection
  * Styles:

    * `.compact`
    * `.graphical`
    * `.wheel`
    * `.plain` (compact with hidden label)
  * Optional:

    * Date range
    * Tint color
    * Disabled state
  * Accessibility support

* **`ReusableProgressView`**

  * Supports two states:

    * `.activityIndicator`
    * `.progress(value:total:)`
  * Styles:

    * `.linear`
    * `.circular`
    * `.circularProgress(lineWidth:)` (custom ring style)
  * Features:

    * Optional label (text or custom view)
    * Custom circular progress with percentage
    * Tint support
    * Accessibility identifier

---

## Requirements

* **Swift**: 6.2
* **iOS**: 15.0+
* **macOS**: 12.0+

---

## Installation

### Swift Package Manager

1. Open Xcode → **File → Add Packages…**
2. Enter:

   ```
   https://github.com/VenkateshDev007/SwiftUI-Elements
   ```
3. Choose version rule (e.g. `Up to Next Major from 1.0.0`)
4. Add `SwiftUIElements` to your target

Or in `Package.swift`:

```swift
dependencies: [
    .package(
        url: "https://github.com/VenkateshDev007/SwiftUI-Elements",
        from: "1.0.0"
    )
]
```

---

## Usage

```swift
import SwiftUI
import SwiftUIElements
```

---

### ReusablePicker

```swift
struct ContentView: View {
    @State private var selection = "One"

    var body: some View {
        ReusablePicker(
            title: "Options",
            selection: $selection,
            style: .segmented
        ) {
            Text("One").tag("One")
            Text("Two").tag("Two")
        }
        .padding()
    }
}
```

---

### ReusableDatePicker

```swift
struct ContentView: View {
    @State private var date = Date()

    var body: some View {
        ReusableDatePicker(
            title: "Select Date",
            selection: $date,
            style: .graphical,
            tint: .blue
        )
        .padding()
    }
}
```

---

### ReusableProgressView

```swift
struct ContentView: View {
    var body: some View {
        VStack(spacing: 20) {

            ReusableProgressView(
                state: .activityIndicator
            )

            ReusableProgressView(
                state: .progress(value: 0.6),
                style: .linear,
                title: "Loading..."
            )

            ReusableProgressView(
                state: .progress(value: 0.75),
                style: .circularProgress(lineWidth: 12)
            )
        }
        .padding()
    }
}
```

---

## API Reference

### `ReusablePicker`

```swift
public enum ReusablePickerStyle {
    case automatic
    case segmented
    case wheel
    case menu
}
```

---

### `ReusableDatePicker`

```swift
public enum ReusableDatePickerStyle {
    case compact
    case graphical
    case wheel
    case plain
}
```

---

### `ReusableProgressView`

```swift
public enum ReusableProgressState {
    case activityIndicator
    case progress(value: Double, total: Double = 1.0)
}

public enum ReusableProgressStyle {
    case linear
    case circular
    case circularProgress(lineWidth: CGFloat = 10)
}
```

---

## Testing

Run tests using:

```bash
swift test
```

Or in Xcode:

* Select scheme → **Product → Test (⌘U)**

---
