[README.md](https://github.com/user-attachments/files/25839781/README.md)
## SwiftUIElements

`SwiftElements` is a small SwiftUI component library that provides a set of reusable, configurable UI components (Button, Image, TextField, Slider, Toggle). It targets **iOS 15+** and **macOS 12+**.

### Features

- **`ReusableButton` SwiftUI view**
  - Configurable **title**
  - Multiple **styles**:
    - `.primary` – uses `buttonStyle(.borderedProminent)`
    - `.secondary` – uses `buttonStyle(.bordered)`
    - `.destructive` – uses `buttonStyle(.borderedProminent)` (tinted red)
    - `.plain` – uses `buttonStyle(.plain)`
    - `.borderless` – uses `buttonStyle(.borderless)`
  - Optional **accessibility identifier** for UI tests
  - Simple closure-based `action` handler
- **`ReusableImage` SwiftUI view**
  - Supports **SF Symbols** (`systemName`), **asset images**, and **remote images** (`url`) via `AsyncImage`
  - Optional **template** style (tint color)
  - Optional **fixed size** and `resizable` support
  - Optional **accessibility identifier**
- **`ReusableTextField` SwiftUI view**
  - `Binding<String>`-based
  - Optional **prompt** (placeholder)
  - Basic `textFieldStyle` options (`.roundedBorder`, `.plain`, `.automatic`)
  - Optional **accessibility identifier**
- **`ReusableSlider` SwiftUI view**
  - `Binding<Double>`-based
  - Configurable **range** and optional **step**
  - Optional **accessibility identifier**
- **`ReusableToggle` SwiftUI view**
  - `Binding<Bool>`-based
  - Optional **accessibility identifier**

### Requirements

- **Swift**: 6.2 tools version (compatible Swift toolchain)
- **Platforms**:
  - iOS 15.0+
  - macOS 12.0+

### Installation

#### Swift Package Manager

You can add `SwiftUIElements` to your project using Swift Package Manager.

1. In Xcode, go to:
   - `File` → `Add Packages…`
2. Enter the repository URL:
   - `https://github.com/VenkateshDev007/SwiftUI-Elements`
3. Choose the version rule that fits your needs, for example:
   - **Exact** `1.0.0` or
   - **Up to Next Major** from `1.0.0`
4. Add the **`SwiftUIElements`** product to your app target.

Alternatively, in your own `Package.swift`:

```swift
dependencies: [
    .package(
        url: "https://github.com/VenkateshDev007/SwiftUI-Elements",
        from: "1.0.0"
    )
],
targets: [
    .target(
        name: "YourApp",
        dependencies: [
            .product(name: "SwiftUIElements", package: "SwiftUI-Elements")
        ]
    )
]
```

### Usage

Import the module in your SwiftUI view:

```swift
import SwiftUI
import SwiftUIElements
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

#### Button with icon + text label

```swift
struct ContentView: View {
    var body: some View {
        ReusableButton(style: .primary, action: {}) {
            Label("Continue", systemImage: "chevron.right")
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

#### ReusableImage

```swift
struct ContentView: View {
    var body: some View {
        VStack(spacing: 16) {
            ReusableImage(systemName: "star.fill")

            ReusableImage(
                systemName: "star.fill",
                style: .template(foregroundColor: .yellow),
                size: .init(width: 24, height: 24),
                accessibilityId: "star_icon"
            )

            ReusableImage(
                url: URL(string: "https://picsum.photos/200"),
                size: .init(width: 80, height: 80),
                resizable: true,
                aspectMode: .fill,
                accessibilityId: "remote_image"
            )
            .clipped()
        }
        .padding()
    }
}
```

#### ReusableTextField

```swift
struct ContentView: View {
    @State private var name = ""

    var body: some View {
        ReusableTextField(
            text: $name,
            style: .roundedBorder,
            prompt: Text("Enter name"),
            accessibilityId: "name_field"
        )
        .padding()
    }
}
```

#### ReusableSlider

```swift
struct ContentView: View {
    @State private var volume = 0.5

    var body: some View {
        ReusableSlider(
            title: "Volume",
            value: $volume,
            in: 0...1,
            step: 0.1,
            accessibilityId: "volume_slider"
        )
        .padding()
    }
}
```

#### ReusableToggle

```swift
struct ContentView: View {
    @State private var isEnabled = true

    var body: some View {
        ReusableToggle(
            title: "Enabled",
            isOn: $isEnabled,
            accessibilityId: "enabled_toggle"
        )
        .padding()
    }
}
```

### API Reference

#### `ReusableButton`

```swift
public enum ReusableButtonStyle: Sendable {
    case primary
    case secondary
    case destructive
    case plain
    case borderless
}

public struct ReusableButton<Label: View>: View {
    public typealias Style = ReusableButtonStyle

    public init(
        title: String,
        style: Style = .primary,
        accessibilityId: String? = nil,
        action: @escaping () -> Void
    )

    public init(
        style: Style = .primary,
        accessibilityId: String? = nil,
        action: @escaping () -> Void,
        @ViewBuilder label: () -> Label
    )
}
```

- **`title`**: Text shown on the button.
- **`style`**: Visual style (`.primary`, `.secondary`, `.destructive`, `.plain`, `.borderless`).
- **`accessibilityId`**: Optional `accessibilityIdentifier` applied to the underlying view.
- **`action`**: Closure invoked when the button is tapped.

#### `ReusableImage`

```swift
public struct ReusableImage: View {
    public enum Source: Sendable, Hashable {
        case system(name: String)
        case asset(name: String)
        case remote(url: URL?)
    }

    public enum Style: Sendable, Hashable {
        case original
        case template(foregroundColor: Color)
    }

    public init(
        source: Source,
        style: Style = .original,
        size: CGSize? = nil,
        resizable: Bool = false,
        aspectMode: ContentMode = .fit,
        accessibilityId: String? = nil
    )

    public init(
        url: URL?,
        style: Style = .original,
        size: CGSize? = nil,
        resizable: Bool = false,
        aspectMode: ContentMode = .fit,
        accessibilityId: String? = nil
    )
}
```

#### `ReusableTextField`

```swift
public struct ReusableTextField: View {
    public enum Style: Sendable, Hashable {
        case automatic
        case roundedBorder
        case plain
    }

    public init(
        title: String,
        text: Binding<String>,
        style: Style = .roundedBorder,
        prompt: String? = nil,
        accessibilityId: String? = nil
    )

    public init(
        text: Binding<String>,
        style: Style = .roundedBorder,
        prompt: Text? = nil,
        accessibilityId: String? = nil
    )
}
```

#### `ReusableSlider`

```swift
public struct ReusableSlider<Label: View>: View {
    public init(
        title: String,
        value: Binding<Double>,
        in range: ClosedRange<Double> = 0...1,
        step: Double? = nil,
        accessibilityId: String? = nil
    )

    public init(
        value: Binding<Double>,
        in range: ClosedRange<Double> = 0...1,
        step: Double? = nil,
        accessibilityId: String? = nil,
        @ViewBuilder label: () -> Label
    )
}
```

#### `ReusableToggle`

```swift
public struct ReusableToggle: View {
    public init(
        title: String,
        isOn: Binding<Bool>,
        accessibilityId: String? = nil
    )

    public init(
        isOn: Binding<Bool>,
        accessibilityId: String? = nil
    )
}
```

### Testing

This package includes basic unit tests for the reusable SwiftUI components.

To run tests from the command line:

```bash
swift test
```

Or in Xcode:

- Select the `SwiftUIElements` scheme.
- Use `Product` → `Test` (⌘U).

### License

Specify your license here (e.g., MIT, Apache 2.0, proprietary). Update this section based on how you intend others to use this package.
