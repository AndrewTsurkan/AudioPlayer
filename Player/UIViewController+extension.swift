//
//  ViewController+extension.swift
//  Player
//
//  Created by Андрей Цуркан on 08.06.2023.

import UIKit

extension UIViewController {
    func hideNavigationBar() {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }

    func showNavigationBar() {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
}
