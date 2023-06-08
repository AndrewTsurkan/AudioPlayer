//
//  ViewController.swift
//  Player
//
//  Created by Андрей Цуркан on 05.06.2023.
//

import UIKit

class MusicListViewController: UIViewController {
    
   private var table = UITableView()
    var songs = [Song]()
    var currentSongIndex: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        table.separatorColor = .white
        title = "Music"
        navigationController?.navigationBar.prefersLargeTitles = true

        setupTableView()
        configureSongs()
    }
    
    func setupTableView() {
        view.addSubview(table)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.delegate = self
        table.dataSource = self
        table.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.reusedId)
        
        [table.topAnchor.constraint(equalTo: view.topAnchor),
         table.leftAnchor.constraint(equalTo: view.leftAnchor),
         table.rightAnchor.constraint(equalTo: view.rightAnchor),
         table.bottomAnchor.constraint(equalTo: view.bottomAnchor)].forEach{ $0.isActive = true }
    }
    
    func configureSongs() {
        songs.append(Song(trackName: "Beauty", artistName: "ROCKET", posterName: "0"))
        songs.append(Song(trackName: "Last Day", artistName: "Mr.Crow",posterName: "1"))
        songs.append(Song(trackName: "it's Only", artistName: "Move", posterName: "2"))
    }
}

extension MusicListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       guard let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.reusedId, for: indexPath) as? TableViewCell else { return UITableViewCell() }
        let song = songs[indexPath.row]
        cell.trackName.text = song.trackName
        cell.artistName.text = song.artistName
        let posterName = song.posterName
        cell.posterImageView.image = UIImage(named: posterName)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let song = songs[indexPath.row]
        let audioVC = AudioPlayer(song: song)
        audioVC.modalPresentationStyle = .fullScreen
        audioVC.delegate = self
        present(audioVC, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
        currentSongIndex = indexPath.row
        
    }
}

extension MusicListViewController: AudioPlayerDelegate {
    func nextSong() -> Song? {
        guard var currentSongIndex else { return nil}
        if currentSongIndex == songs.count - 1  {
            currentSongIndex = 0
            self.currentSongIndex = currentSongIndex
        }else {
            currentSongIndex += 1
            self.currentSongIndex = currentSongIndex
        }
        return songs[currentSongIndex]
    }
    
    func backSong() -> Song? {
        guard var currentSongIndex else { return nil}
        if currentSongIndex == 0 {
            currentSongIndex = songs.count - 1
            self.currentSongIndex = currentSongIndex
        }else{
            currentSongIndex -= 1
            self.currentSongIndex = currentSongIndex
            }
        return songs[currentSongIndex]
    }
}

