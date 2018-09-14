//
//  AlbumInfoCell.swift
//  ForaSoftTest
//
//  Created by Руслан Ахриев on 13.09.2018.
//  Copyright © 2018 Руслан Ахриев. All rights reserved.
//

import UIKit

class AlbumInfoCell: UICollectionViewCell {
    
    @IBOutlet weak var albumImage: UIImageView!
    @IBOutlet weak var albumTitleLabel: UILabel!
    @IBOutlet weak var albumAuthorLabel: UILabel!
    
    func updateCell (album: Album) {
        let imageUrl = URL(string: album.artworkUrl100)
        
        DispatchQueue.global().async {
            if let imageData = try? Data(contentsOf: imageUrl!) {
                DispatchQueue.main.async {
                    self.albumImage.image = UIImage(data: imageData)
                }
            }
        }
        albumTitleLabel.text = album.collectionName
        albumAuthorLabel.text = album.artistName
    }
    
}
