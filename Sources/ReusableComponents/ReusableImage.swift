//
//  ReusableImage.swift
//  SwiftElements
//
//  Created by Polepalli, Venkatesh on 10/03/26.
//

import SwiftUI

public struct ReusableImage: View {
    public enum Source: Sendable, Hashable {
        case system(name: String)
        case asset(name: String)
    }

    public enum Style: Sendable, Hashable {
        case original
        case template(foregroundColor: Color)
    }

    private let source: Source
    private let style: Style
    private let size: CGSize?
    private let resizable: Bool
    private let aspectMode: ContentMode
    private let accessibilityId: String?

    public init(
        source: Source,
        style: Style = .original,
        size: CGSize? = nil,
        resizable: Bool = false,
        aspectMode: ContentMode = .fit,
        accessibilityId: String? = nil
    ) {
        self.source = source
        self.style = style
        self.size = size
        self.resizable = resizable
        self.aspectMode = aspectMode
        self.accessibilityId = accessibilityId
    }

    public init(
        systemName: String,
        style: Style = .original,
        size: CGSize? = nil,
        resizable: Bool = false,
        aspectMode: ContentMode = .fit,
        accessibilityId: String? = nil
    ) {
        self.init(
            source: .system(name: systemName),
            style: style,
            size: size,
            resizable: resizable,
            aspectMode: aspectMode,
            accessibilityId: accessibilityId
        )
    }

    public init(
        assetName: String,
        style: Style = .original,
        size: CGSize? = nil,
        resizable: Bool = false,
        aspectMode: ContentMode = .fit,
        accessibilityId: String? = nil
    ) {
        self.init(
            source: .asset(name: assetName),
            style: style,
            size: size,
            resizable: resizable,
            aspectMode: aspectMode,
            accessibilityId: accessibilityId
        )
    }

    public var body: some View {
        content
            .reusableAccessibilityIdentifier(accessibilityId)
    }

    @ViewBuilder
    private var content: some View {
        let base = image

        if resizable {
            styled(base)
                .resizable()
                .aspectRatio(contentMode: aspectMode)
                .frame(width: size?.width, height: size?.height)
        } else {
            styled(base)
                .frame(width: size?.width, height: size?.height)
        }
    }

    private var image: Image {
        switch source {
        case .system(let name):
            Image(systemName: name)
        case .asset(let name):
            Image(name)
        }
    }

    @ViewBuilder
    private func styled(_ image: Image) -> some View {
        switch style {
        case .original:
            image
        case .template(let foregroundColor):
            image
                .renderingMode(.template)
                .foregroundStyle(foregroundColor)
        }
    }
}


