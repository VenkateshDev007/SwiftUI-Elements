//
//  ReusableImage.swift
//  SwiftElements
//
//  Created by Polepalli, Venkatesh on 10/03/26.
//

import SwiftUI
import Foundation

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

    public init(systemName: String, style: Style = .original, size: CGSize? = nil,
                resizable: Bool = false, aspectMode: ContentMode = .fit,
                accessibilityId: String? = nil) {
        self.init(source: .system(name: systemName), style: style,
                  size: size, resizable: resizable,
                  aspectMode: aspectMode, accessibilityId: accessibilityId)
    }

    public init(assetName: String, style: Style = .original, size: CGSize? = nil,
                resizable: Bool = false, aspectMode: ContentMode = .fit,
                accessibilityId: String? = nil) {
        self.init(source: .asset(name: assetName), style: style,
                  size: size, resizable: resizable,
                  aspectMode: aspectMode, accessibilityId: accessibilityId)
    }

    public init(url: URL?, style: Style = .original, size: CGSize? = nil,
                resizable: Bool = false, aspectMode: ContentMode = .fit,
                accessibilityId: String? = nil) {
        self.init(source: .remote(url: url), style: style,
                  size: size, resizable: resizable,
                  aspectMode: aspectMode, accessibilityId: accessibilityId)
    }

    public var body: some View {
        content
            .reusableAccessibilityIdentifier(accessibilityId)
    }

    @ViewBuilder
    private var content: some View {
        switch source {
        case .system, .asset:
            localContent
        case .remote(let url):
            AsyncRemoteImage(
                url: url,
                style: style,
                size: size,
                resizable: resizable,
                aspectMode: aspectMode
            )
        }
    }

    @ViewBuilder
    private var localContent: some View {
        switch style {
        case .original:
            if resizable {
                image.resizable()
                    .aspectRatio(contentMode: aspectMode)
                    .frame(width: size?.width, height: size?.height)
            } else {
                image.frame(width: size?.width, height: size?.height)
            }
        case .template(let foregroundColor):
            if resizable {
                image.renderingMode(.template)
                    .resizable()
                    .aspectRatio(contentMode: aspectMode)
                    .foregroundStyle(foregroundColor)
                    .frame(width: size?.width, height: size?.height)
            } else {
                image.renderingMode(.template)
                    .foregroundStyle(foregroundColor)
                    .frame(width: size?.width, height: size?.height)
            }
        }
    }

    private var image: Image {
        switch source {
        case .system(let name): Image(systemName: name)
        case .asset(let name): Image(name)
        case .remote: Image(systemName: "photo")
        }
    }
}

// MARK: - Dedicated Async Remote Image Struct
struct AsyncRemoteImage: View {
    let url: URL?
    let style: ReusableImage.Style
    let size: CGSize?
    let resizable: Bool
    let aspectMode: ContentMode

    var body: some View {
        AsyncImage(url: url) { phase in
            switch phase {
            case .empty:
                ProgressView()
                    .frame(width: size?.width, height: size?.height)
            case .failure:
                Image(systemName: "photo")
                    .frame(width: size?.width, height: size?.height)
            case .success(let loadedImage):
                switch style {
                case .original:
                    if resizable {
                        loadedImage.resizable()
                            .aspectRatio(contentMode: aspectMode)
                            .frame(width: size?.width, height: size?.height)
                    } else {
                        loadedImage.frame(width: size?.width, height: size?.height)
                    }
                case .template(let foregroundColor):
                    if resizable {
                        loadedImage.renderingMode(.template)
                            .resizable()
                            .aspectRatio(contentMode: aspectMode)
                            .foregroundStyle(foregroundColor)
                            .frame(width: size?.width, height: size?.height)
                    } else {
                        loadedImage.renderingMode(.template)
                            .foregroundStyle(foregroundColor)
                            .frame(width: size?.width, height: size?.height)
                    }
                }
            @unknown default:
                EmptyView()
            }
        }
    }
}
