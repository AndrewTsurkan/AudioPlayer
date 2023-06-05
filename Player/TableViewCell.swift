//
//  TableViewCell.swift
//  Player
//
//  Created by Андрей Цуркан on 05.06.2023.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    static var reusedId = "InstallCell"
    let posterImageView = UIImageView()
    var trackName = UILabel()
    var artistName = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupPoster()
        setupTrackName()
        setupArtistName()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupPoster() {
        addSubview(posterImageView)
        posterImageView.translatesAutoresizingMaskIntoConstraints = false
        posterImageView.layer.cornerRadius = 40
        posterImageView.contentMode = .scaleAspectFit
        posterImageView.clipsToBounds = true
        
        [posterImageView.topAnchor.constraint(equalTo: topAnchor,constant: 5),
         posterImageView.leftAnchor.constraint(equalTo: leftAnchor,constant: 10),
         posterImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
         posterImageView.heightAnchor.constraint(equalToConstant: 120),
         posterImageView.widthAnchor.constraint(equalToConstant: 120)].forEach { $0.isActive = true }
    }
    
    private func  setupTrackName() {
        addSubview(trackName)
        trackName.translatesAutoresizingMaskIntoConstraints = false
        trackName.font = UIFont(name: "Helvetrica-Bold", size: 24)
        
        
        [trackName.topAnchor.constraint(equalTo: topAnchor, constant: 13),
         trackName.leftAnchor.constraint(equalTo: posterImageView.rightAnchor, constant: 20)].forEach { $0.isActive = true }
    }
    
    private func setupArtistName() {
        addSubview(artistName)
        artistName.translatesAutoresizingMaskIntoConstraints = false
        artistName.font = UIFont.systemFont(ofSize: 13)
        
        [artistName.topAnchor.constraint(equalTo: trackName.bottomAnchor),
         artistName.leftAnchor.constraint(equalTo: posterImageView.rightAnchor, constant: 20),
         artistName.heightAnchor.constraint(equalToConstant: 20)].forEach { $0.isActive = true }
    }
    
}
