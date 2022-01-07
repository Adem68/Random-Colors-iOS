//
//  ClipboardManager.swift
//  RandomColors
//
//  Created by Adem Özcan on 7.01.2022.
//

import UIKit
import Drops

final class ClipboardManager {
    static func showToast(with color: UIColor){
        UIPasteboard.general.string = color.hexString
        let drop = Drop(
            title: "\(color.accessibilityName.capitalized) \(color.hexString)",
            subtitle: "Copied to the clipboard",
            icon: UIImage(systemName: "checkmark.circle.fill"),
            action: .init {
                Drops.hideCurrent()
            })
        Drops.show(drop)
    }
}
