//
//  AboutAlbumVC.swift
//  ForaSoftTest
//
//  Created by Руслан Ахриев on 13.09.2018.
//  Copyright © 2018 Руслан Ахриев. All rights reserved.
//

import UIKit

class AboutAlbumVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var album : Album!
    var albmImage : UIImage!
    var tracks = [Track]()
    
    @IBOutlet weak var albumNameLabel: UILabel!
    @IBOutlet weak var albumImage: UIImageView!
    @IBOutlet weak var authorNameLabel: UILabel!
    @IBOutlet weak var countryNameLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var albumYearLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView(frame: .zero)
        updateLabels()
        loadTracks()
    }
    
    func updateLabels () {
        albumNameLabel.text = album.collectionName
        authorNameLabel.text = album.artistName
        genreLabel.text = album.primaryGenreName
        countryNameLabel.text = album.country
        albumYearLabel.text = album.releaseDate
        albumImage.image = albmImage
    }
    
    func loadTracks() {
        print(album.collectionId)
        WebService.instance.getAlbumTracks(collectionId: album.collectionId) { (requestedTracks) in
            self.tracks = requestedTracks
            print(requestedTracks)
            DispatchQueue.main.async {
                self.tableView.reloadData()
                
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tracks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "TrackCell", for: indexPath) as? TrackCell {
            cell.updateCell(track: tracks[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
}
