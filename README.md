[README.md](https://github.com/user-attachments/files/25839781/README.md)
## SwiftElements

`SwiftElements` is a small SwiftUI component library that currently provides a reusable, configurable button view called `ReusableButton`. It targets **iOS 15+** and **macOS 12+**.

### Features

- **`ReusableButton` SwiftUI view**
  - Configurable **title**
  - Two **styles**:
    - `.primary` – uses `buttonStyle(.borderedProminent)`
    - `.secondary` – uses `buttonStyle(.bordered)`
  - Optional **accessibility identifier** for UI tests
  - Simple closure-based `action` handler

### Requirements

- **Swift**: 6.2 tools version (compatible Swift toolchain)
- **Platforms**:
  - iOS 15.0+
  - macOS 12.0+

### Installation

#### Swift Package Manager

You can add `SwiftElements` to your project using Swift Package Manager.

1. In Xcode, go to:
   - `File` → `Add Packages…`
2. Enter the repository URL:
   - `https://github.com/VenkateshDev007/SampleSwiftuiPackage.git`
3. Choose the version rule that fits your needs, for example:
   - **Exact** `1.0.0` or
   - **Up to Next Major** from `1.0.0`
4. Add the **`SwiftElements`** product to your app target.

Alternatively, in your own `Package.swift`:

```swift
dependencies: [
    .package(
        url: "https://github.com/VenkateshDev007/SampleSwiftuiPackage.git",
        from: "1.0.0"
    )
],
targets: [
    .target(
        name: "YourApp",
        dependencies: [
            .product(name: "SwiftElements", package: "SampleSwiftuiPackage")
        ]
    )
]
```

### Usage

Import the module in your SwiftUI view:

```swift
import SwiftUI
import SwiftElements
```

#### Basic primary button

```swift
struct ContentView: View {
    var body: some View {
        ReusableButton(title: "Continue") {
            // Handle tap
        }
        .padding()
    }
}
```

#### Secondary style

```swift
struct ContentView: View {
    var body: some View {
        ReusableButton(title: "Cancel", style: .secondary) {
            // Handle cancel
        }
        .padding()
    }
}
```

#### With accessibility identifier

```swift
struct ContentView: View {
    var body: some View {
        ReusableButton(
            title: "Continue",
            accessibilityId: "continue_button"
        ) {
            // Handle tap
        }
        .padding()
    }
}
```

### API Reference

#### `ReusableButton`

```swift
public struct ReusableButton: View {
    public enum Style: Sendable {
        case primary
        case secondary
    }

    public init(
        title: String,
        style: Style = .primary,
        accessibilityId: String? = nil,
        action: @escaping () -> Void
    )
}
```

- **`title`**: Text shown on the button.
- **`style`**: Visual style (`.primary` or `.secondary`).
- **`accessibilityId`**: Optional `accessibilityIdentifier` applied to the underlying view.
- **`action`**: Closure invoked when the button is tapped.

### Testing

This package includes basic unit tests for `ReusableButton`.

To run tests from the command line:

```bash
swift test
```

Or in Xcode:

- Select the `SwiftElements` scheme.
- Select the `SwiftElements` scheme.
- Use `Product` → `Test` (⌘U).

### License

Specify your license here (e.g., MIT, Apache 2.0, proprietary). Update this section based on how you intend others to use this package.

