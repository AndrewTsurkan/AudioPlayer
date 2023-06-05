//
//  ViewController.swift
//  Player
//
//  Created by Андрей Цуркан on 05.06.2023.
//

import UIKit

struct Song {
    let trackName: String
    let artistName: String
}

class MusicListViewController: UIViewController {
    
    var table = UITableView()
    var songs = [Song]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Music"
        navigationController?.navigationBar.prefersLargeTitles = true
        table.separatorColor = .white

        setupTebleView()
        configureSongs()
    }
    
    func configureSongs() {
        songs.append(Song(trackName: "Beauty", artistName: "ROCKET"))
        songs.append(Song(trackName: "Universal", artistName: "Mr.Crow"))
        songs.append(Song(trackName: "It's Only Image", artistName: "Move"))
    }
    
    func setupTebleView() {
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
}

extension MusicListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       guard let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.reusedId, for: indexPath) as? TableViewCell else { return UITableViewCell() }
        let playList = songs[indexPath.row]
        cell.trackName.text = playList.trackName
        cell.artistName.text = playList.artistName
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
