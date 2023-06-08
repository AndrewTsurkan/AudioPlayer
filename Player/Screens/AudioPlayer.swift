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
    private let backwardButton = UIButton()
    private let slider = UISlider()
    private let trackName = UILabel()
    private let artistName = UILabel()
    private let timeLabel = UILabel()
    private let backButton = UIButton()
    private let timeLeftLabel = UILabel()
    var observer: Any?
    
    weak var delegate: AudioPlayerDelegate?
    
    var song: Song
    var player: AVPlayer?
    
    init(song: Song) {
        self.song = song
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBackButton()
        setupImageView()
        setupTrackName()
        setupArtistName()
        setupSlider()
        setupStackView()
        setupButtons()
        playSong()
        setupTimeLabel()
        setupTimeLeftLabel()
        installSubview()
        view.backgroundColor = UIColor(named: "background")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        player?.pause()
    }
    
    private func setupBackButton() {
        view.addSubview(backButton)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.setImage(UIImage(named: "back"), for: .normal)
        backButton.addTarget(self, action: #selector(actionBackButton), for: .touchUpInside)
        
        [backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
         backButton.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 20)].forEach{ $0.isActive = true }
    }
    
    @objc private func actionBackButton() {
        dismiss(animated: true)
    }
    
    private func setupImageView() {
        view.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 14
        
        [imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
         imageView.leftAnchor.constraint(equalTo: view.leftAnchor,constant: 30),
         imageView.rightAnchor.constraint(equalTo: view.rightAnchor,constant: -30),
         imageView.heightAnchor.constraint(equalToConstant: 400)].forEach{ $0.isActive = true }
    }
    
    private func setupTrackName() {
        view.addSubview(trackName)
        trackName.translatesAutoresizingMaskIntoConstraints = false
        trackName.font = UIFont(name: "Helvetrica-Bold", size: 24)
        trackName.textColor = .white
        
        [trackName.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 13),
         trackName.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30)].forEach { $0.isActive = true }
    }
    
    private func setupArtistName() {
        view.addSubview(artistName)
        artistName.translatesAutoresizingMaskIntoConstraints = false
        artistName.font = UIFont.systemFont(ofSize: 13)
        artistName.textColor = UIColor(named: "artistNameColor")
        
        [artistName.topAnchor.constraint(equalTo: trackName.bottomAnchor,constant: 5),
         artistName.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30)].forEach { $0.isActive = true }
    }
    
    private func setupSlider() {
        view.addSubview(slider)
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.addTarget(self, action: #selector(sliderAction), for: .allTouchEvents)
        slider.setThumbImage(UIImage(named: "circleSmole.fill"), for: .normal)
        slider.minimumTrackTintColor = .white
        slider.maximumTrackTintColor = UIColor(named: "artistNameColor")
        
        [slider.topAnchor.constraint(equalTo: artistName.bottomAnchor, constant: 10),
         slider.leftAnchor.constraint(equalTo: view.leftAnchor,constant: 70),
         slider.rightAnchor.constraint(equalTo: view.rightAnchor,constant: -70),
         slider.heightAnchor.constraint(equalToConstant: 30)].forEach{ $0.isActive = true }
    }
    
    @objc private func sliderAction(_ sender: UISlider) {
        player?.seek(to: CMTime(seconds: Double(slider.value), preferredTimescale: 1000))
    }
    
    private func setupStackView() {
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        
        [stackView.topAnchor.constraint(equalTo: slider.bottomAnchor, constant: 5),
         stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
         stackView.widthAnchor.constraint(equalToConstant: 150),
         stackView.heightAnchor.constraint(equalToConstant: 60)].forEach{ $0.isActive = true }
    }
    
    private func setupButtons() {
        stackView.addArrangedSubview(backwardButton)
        backwardButton.setImage(UIImage(named: "backward.end.fill" ), for: .normal)
        backwardButton.addTarget(self, action: #selector(backwardButtonAction), for: .touchUpInside)
        
        stackView.addArrangedSubview(pauseButton)
        pauseButton.setImage(UIImage(named: "pause.circle.fill"), for: .normal)
        pauseButton.addTarget(self, action: #selector(pauseButtonAction), for: .touchUpInside)
        
        stackView.addArrangedSubview(forwardButton)
        forwardButton.setImage(UIImage(named: "forward.end.fill"), for: .normal)
        forwardButton.addTarget(self, action: #selector(forwardButtonAction), for: .touchUpInside)
    }
    
    @objc private func pauseButtonAction() {
        if player?.timeControlStatus == .playing {
            pauseButton.setImage(UIImage(named: "play.circle.fill"), for: .normal)
            player?.pause()
        }else {
            pauseButton.setImage(UIImage(named: "pause.circle.fill"), for: .normal)
            
            player?.play()
        }
    }
    
    @objc  private func  backwardButtonAction() {
        guard let song = delegate?.backSong() else { return }
        self.song = song
        player?.pause()
        installSubview()
        if let observer {
            player?.removeTimeObserver(observer)
        }
        
        player = nil
        playSong()
    }
    
    @objc  private func forwardButtonAction() {
        guard let song = delegate?.nextSong() else { return }
        self.song = song
        player?.pause()
        installSubview()
        if let observer {
            player?.removeTimeObserver(observer)
        }
        
        player = nil
        playSong()
    }
    
    private func playSong() {
        guard let audio = Bundle.main.path(forResource: song.trackName, ofType: "mp3") else { return }
        player = AVPlayer(url: URL(fileURLWithPath: audio))
        player?.play()
        observer = player?.addPeriodicTimeObserver(forInterval: CMTime(value: 1, timescale: 1000), queue: DispatchQueue.main) { [weak self] time in
            let totalSeconds = Int(time.seconds)
            self?.timeLabel.text = self?.timeConversion(totalSeconds)
            self?.slider.value = Float(time.seconds)
            guard let timeTrack = self?.player?.currentItem?.duration else { return }
            let allTimeSeconds = Int(CMTimeGetSeconds(timeTrack))
            self?.timeLeftLabel.text = self?.timeConversion(allTimeSeconds)
            self?.slider.maximumValue = Float(CMTimeGetSeconds(timeTrack))
            if allTimeSeconds == totalSeconds {
                self?.forwardButtonAction()
            }
        }
    }
    
    private func setupTimeLabel() {
        view.addSubview(timeLabel)
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        timeLabel.font = UIFont.systemFont(ofSize: 13)
        timeLabel.textAlignment = .right
        
        [timeLabel.topAnchor.constraint(equalTo: artistName.bottomAnchor, constant: 19),
         timeLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15),
         timeLabel.rightAnchor.constraint(equalTo: slider.leftAnchor, constant: -5)].forEach { $0.isActive = true }
    }
    
    private func setupTimeLeftLabel() {
        view.addSubview(timeLeftLabel)
        timeLeftLabel.translatesAutoresizingMaskIntoConstraints = false
        timeLeftLabel.font = UIFont.systemFont(ofSize: 13)
        timeLeftLabel.textAlignment = .left
        
        [timeLeftLabel.topAnchor.constraint(equalTo: artistName.bottomAnchor, constant: 19),
         timeLeftLabel.leftAnchor.constraint(equalTo: slider.rightAnchor, constant: 5),
         timeLeftLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10)].forEach { $0.isActive = true }
    }
    
    private func installSubview() {
        imageView.image = UIImage(named: song.posterName)
        trackName.text = song.trackName
        artistName.text = song.artistName
    }
    
    private func timeConversion(_ allSeconds: Int) -> String {
        let minutes = allSeconds / 60
        let seconds = allSeconds - minutes * 60
        let time = "\(minutes):\(seconds < 10 ? "0" : "")\(seconds)"
        return time
    }
    
}
