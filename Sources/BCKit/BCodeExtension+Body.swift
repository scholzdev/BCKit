//
//  File.swift
//  
//
//  Created by Wouter Hennen on 03/01/2023.
//

import Foundation
import ExtensionKit

struct EmptyAppExtensionScene: AppExtensionScene {
    var body: Never {
        fatalError()
    }
}

public extension BCodeExtension {
    var body: some AppExtensionScene {
        EmptyAppExtensionScene()
    }
}

public extension BCodeExtension where Self: SettingsExtension {
    var body: some AppExtensionScene {
        settingsScene
    }
}

public extension BCodeExtension where Self: SidebarExtension {
    var body: some AppExtensionScene {
        sidebarScenes
    }
}

public extension BCodeExtension where Self: SettingsExtension & SidebarExtension {
    @AppExtensionSceneBuilder
    var body: some AppExtensionScene {
        settingsScene
        sidebarScenes
    }
}
