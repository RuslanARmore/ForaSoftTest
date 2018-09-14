//
//  AlbumSearchVC.swift
//  ForaSoftTest
//
//  Created by Руслан Ахриев on 12.09.2018.
//  Copyright © 2018 Руслан Ахриев. All rights reserved.
//

import UIKit

class AlbumSearchVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {
    
    var albums = [Album]()
    var tracks = [Track]()
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var albumCollectionView: UICollectionView!
 
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        albumCollectionView.delegate = self
        albumCollectionView.dataSource = self
        
        let constraint = (self.view.bounds.size.width - 300) / 4
        albumCollectionView.contentInset = UIEdgeInsets(top: constraint, left: constraint, bottom: constraint, right: constraint)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowAlbumDetailVC" {
            if let destinationVC = segue.destination as? AboutAlbumVC {
                if let album = sender as? Album {
                    destinationVC.album = album
                    let index = albums.index(where: {$0 === album})
                    let indexPath = IndexPath(row: index!, section: 0)
                    if let cell = albumCollectionView.cellForItem(at: indexPath) as? AlbumInfoCell {
                        destinationVC.albmImage = cell.albumImage.image
                    }
                }
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return albums.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AlbumInfoCell", for: indexPath) as? AlbumInfoCell {
            cell.updateCell(album: albums[indexPath.row])
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let album = albums[indexPath.row]
        performSegue(withIdentifier: "ShowAlbumDetailVC", sender: album)
        searchBar.resignFirstResponder()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if searchBar.text != nil || searchBar.text != "" {
            WebService.instance.getAlbums(searchRequest: searchBar.text!) { (requestedAlbums) in
                self.albums = requestedAlbums.sorted(by: {$0.collectionName < $1.collectionName})
                DispatchQueue.main.async {
                    self.albumCollectionView.reloadData()
                }
            }
        }
        searchBar.resignFirstResponder()
    }

}
