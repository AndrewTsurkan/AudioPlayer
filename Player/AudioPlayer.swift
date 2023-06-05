//
//  AudioPlayer.swift
//  Player
//
//  Created by Андрей Цуркан on 05.06.2023.
//

import UIKit

class AudioPlayer: UIViewController {
    private let imageView = UIImageView()
    private let stackView = UIStackView()
    private let pauseButton = UIButton()
    private let nextButton = UIButton()
    private let backButton = UIButton()
    private let slider = UISlider()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupImageView()
        setupSlider()
    }
    
    private func setupImageView() {
        view.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        [imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
         imageView.leftAnchor.constraint(equalTo: view.leftAnchor,constant: 30),
         imageView.rightAnchor.constraint(equalTo: view.rightAnchor,constant: -30),
         imageView.heightAnchor.constraint(equalToConstant: 400)].forEach{ $0.isActive = true }
    }
    
    private func setupSlider() {
        view.addSubview(slider)
        slider.translatesAutoresizingMaskIntoConstraints = false
        
        [slider.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10),
         slider.leftAnchor.constraint(equalTo: view.leftAnchor,constant: 30),
         slider.rightAnchor.constraint(equalTo: view.rightAnchor,constant: -30),
         slider.heightAnchor.constraint(equalToConstant: 30)].forEach{ $0.isActive = true }
    }
    
    private func setupStackView() {
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
    }
}
