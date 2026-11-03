//
//  File.swift
//  
//
//  Created by Wouter Hennen on 30/12/2022.
//

import ExtensionKit
import ExtensionFoundation

public protocol BCodeExtension: AppExtension {

    /// UI scenes of the extension.
    associatedtype Body: AppExtensionScene

    /// Extension Configuration.
    associatedtype Configuration = AppExtensionSceneConfiguration

    /// A brief description of the extension. Should be max a few words.
    var description: String { get }

    /// A list of Entitlements the app needs, e.g. Network Access.
    var entitlements: [Entitlement] { get }

    /// UI scenes of the extension.
    /// Use the default implementation.
    var body: Body { get }
}

extension BCodeExtension {

    var extensionURL: URL {
        Bundle.main.bundleURL
    }

    func gatherAvailableExtensions() -> [ExtensionKind] {
        var extensions: [ExtensionKind] = []

        if self is any SettingsExtension {
            extensions.append(.settings)
        }

        if let self = self as? any SidebarExtension {
            extensions.append(contentsOf: self.availableExtensions)
        }

        return extensions
    }
}

public extension BCodeExtension where Self: AnyObject {
    /// XPC Configuration for communication with b-code.
    /// Use the default implementation.
    var configuration: AppExtensionSceneConfiguration {
        AppExtensionSceneConfiguration(self.body, configuration: SettingsExtensionConfiguration(self))
    }
}

struct SettingsExtensionConfiguration<E: BCodeExtension & AnyObject>: AppExtensionConfiguration {
    public func accept(connection: NSXPCConnection) -> Bool {
        guard let appExtension else {
            return false
        }

        connection.exportedInterface = .init(with: XPCWrappable.self)
        connection.exportedObject = XPCWrapper(appExtension)
        connection.resume()

        return true
    }

    weak var appExtension: E?

    public init(_ appExtension: E) {
        self.appExtension = appExtension
    }
}
