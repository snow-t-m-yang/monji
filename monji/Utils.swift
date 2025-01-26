//
//  Utils.swift
//  monji
//
//  Created by snow on 2025/1/22.
//

import Foundation
import UIKit

final class Ultils {
    static let shared = Ultils()

    private init() {}

    func getTopViewController(
        base: UIViewController? = UIApplication.shared.connectedScenes
            .filter { $0.activationState == .foregroundActive }
            .compactMap { ($0 as? UIWindowScene)?.keyWindow }
            .first?.rootViewController
    ) -> UIViewController? {

        if let navigationController = base as? UINavigationController {
            return getTopViewController(
                base: navigationController.visibleViewController)
        }

        if let tabController = base as? UITabBarController,
            let selected = tabController.selectedViewController
        {
            return getTopViewController(base: selected)
        }

        if let presented = base?.presentedViewController {
            return getTopViewController(base: presented)
        }

        return base
    }
}
