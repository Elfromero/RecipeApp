//
//  EnvironmentValues.swift
//  RecipeApp
//
//  Created by Roman Radchuk on 12/22/24.
//

import SwiftUICore
import UIKit

extension EnvironmentValues {
    
    var orientation: UIDeviceOrientation {
        get { self[OrientationKey.self] }
        set { self[OrientationKey.self] = newValue }
    }
}

private struct OrientationKey: EnvironmentKey {
    static let defaultValue = UIDevice.current.orientation
}
