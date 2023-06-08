//
//  AudioPlayerDelegate.swift
//  Player
//
//  Created by Андрей Цуркан on 08.06.2023.
//

import UIKit

protocol AudioPlayerDelegate: AnyObject {
    func nextSong() -> Song?
    func backSong() -> Song?
}
