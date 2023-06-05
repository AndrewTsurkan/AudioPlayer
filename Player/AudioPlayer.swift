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
    private let forwardButton = UIButton()
    private let backButton = UIButton()
    private let slider = UISlider()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupImageView()
        setupSlider()
        setupStackView()
        setupButtons()
    }
    
    private func setupImageView() {
        view.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .black
        imageView.layer.cornerRadius = 14
        
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
        stackView.axis = .horizontal
        stackView.distribution = .equalCentering
        
        [stackView.topAnchor.constraint(equalTo: slider.bottomAnchor, constant: 5),
         stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
         stackView.widthAnchor.constraint(equalToConstant: 150),
         stackView.heightAnchor.constraint(equalToConstant: 60)].forEach{ $0.isActive = true }
    }
    
    private func setupButtons() {
        stackView.addArrangedSubview(backButton)
        backButton.heightAnchor.constraint(equalToConstant: 58).isActive = true
        
        stackView.addArrangedSubview(pauseButton)
        pauseButton.heightAnchor.constraint(equalToConstant: 58).isActive = true

        stackView.addArrangedSubview(forwardButton)
        forwardButton.heightAnchor.constraint(equalToConstant: 58).isActive = true

        
        pauseButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
        forwardButton.setImage(UIImage(systemName: "forward.fill"), for: .normal)
        backButton.setImage(UIImage(systemName: "backward.fill"), for: .normal)
        
        pauseButton.addTarget(self, action: #selector(asd), for: .touchUpInside)
    }
    
    @objc func asd() {
        pauseButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
    }
}
