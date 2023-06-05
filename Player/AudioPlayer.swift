//
//  AudioPlayer.swift
//  Player
//
//  Created by Андрей Цуркан on 05.06.2023.
//

import UIKit
import MediaPlayer

class AudioPlayer: UIViewController {
    private let imageView = UIImageView()
    private let stackView = UIStackView()
    private let pauseButton = UIButton()
    private let forwardButton = UIButton()
    private let backButton = UIButton()
    private let slider = UISlider()
    private var trackName = UILabel()
    private var artistName = UILabel()
    private var timeLabel = UILabel()
    
    var song: Song
    var player: AVPlayer!
    
    init(songs: Song) {
        self.song = songs
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupImageView()
        setupTrackName()
        setupArtistName()
        setupSlider()
        setupStackView()
        setupButtons()
        settingPlayer()

    }
    private func settingPlayer() {
        view.backgroundColor = .white
        player = AVPlayer(url: URL(fileURLWithPath: Bundle.main.path(forResource: song.trackName, ofType: "mp3")!))
        player.play()
        player.addPeriodicTimeObserver(forInterval: CMTime(value: 1, timescale: 1000), queue: DispatchQueue.main) { time in
            self.timeLabel.text = "\(time.seconds)"
            self.slider.value = Float(time.seconds)
            guard let timeTrack = self.player.currentItem?.duration else { return }
            self.slider.maximumValue = Float(CMTimeGetSeconds(timeTrack))
        }
    }

    private func setupImageView() {
        view.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .black
        imageView.layer.cornerRadius = 14
        imageView.image = UIImage(named: song.posterName)
        
        [imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
         imageView.leftAnchor.constraint(equalTo: view.leftAnchor,constant: 30),
         imageView.rightAnchor.constraint(equalTo: view.rightAnchor,constant: -30),
         imageView.heightAnchor.constraint(equalToConstant: 400)].forEach{ $0.isActive = true }
    }
    
    private func  setupTrackName() {
        view.addSubview(trackName)
        trackName.translatesAutoresizingMaskIntoConstraints = false
        trackName.font = UIFont(name: "Helvetrica-Bold", size: 24)
        trackName.text = song.trackName
        
        
        [trackName.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 13),
         trackName.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30)].forEach { $0.isActive = true }
    }
    
    private func setupArtistName() {
        view.addSubview(artistName)
        artistName.translatesAutoresizingMaskIntoConstraints = false
        artistName.font = UIFont.systemFont(ofSize: 13)
        artistName.text = song.artistName
        
        [artistName.topAnchor.constraint(equalTo: trackName.bottomAnchor,constant: 10),
         artistName.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30)].forEach { $0.isActive = true }
    }
    private func setupTimeLabel() {
        view.addSubview(timeLabel)
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        [timeLabel.topAnchor.constraint(equalTo: artistName.bottomAnchor, constant: 10),
         timeLabel.rightAnchor.constraint(equalTo: slider.leftAnchor, constant: 2)].forEach { $0.isActive = true }
    }
    private func setupSlider() {
        view.addSubview(slider)
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.addTarget(self, action: #selector(sliderAction), for: .allEditingEvents)
        
        [slider.topAnchor.constraint(equalTo: artistName.bottomAnchor, constant: 10),
         slider.leftAnchor.constraint(equalTo: view.leftAnchor,constant: 50),
         slider.rightAnchor.constraint(equalTo: view.rightAnchor,constant: -50),
         slider.heightAnchor.constraint(equalToConstant: 30)].forEach{ $0.isActive = true }
    }
    
    @objc func sliderAction(_ sender: UISlider) {
        player.seek(to: CMTime(seconds: Double(slider.value), preferredTimescale: 1000))
        timeLabel.text = "\(slider.value)"

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
        backButton.setImage(UIImage(systemName: "backward.fill"), for: .normal)
        
        stackView.addArrangedSubview(pauseButton)
        pauseButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)

        stackView.addArrangedSubview(forwardButton)
        forwardButton.setImage(UIImage(systemName: "forward.fill"), for: .normal)
        
        pauseButton.addTarget(self, action: #selector(asd), for: .touchUpInside)
    }
    
    @objc func asd() {
        if player.timeControlStatus == .playing {
            pauseButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
            player.pause()
        }else {
            pauseButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)

            player.play()

        }
    }
}
