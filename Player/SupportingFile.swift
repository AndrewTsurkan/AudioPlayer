//
//  SupportingFile.swift
//  Player
//
//  Created by Андрей Цуркан on 06.06.2023.
//

import Foundation
import UIKit

struct Song {
    let trackName: String
    let artistName: String
    let posterName: String
}

extension UIViewController {
    func hideNavigationBar() {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }

    func showNavigationBar() {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
}
