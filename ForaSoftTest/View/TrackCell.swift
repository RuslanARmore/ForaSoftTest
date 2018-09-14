//
//  TrackCell.swift
//  ForaSoftTest
//
//  Created by Руслан Ахриев on 14.09.2018.
//  Copyright © 2018 Руслан Ахриев. All rights reserved.
//

import UIKit

class TrackCell: UITableViewCell {

    @IBOutlet weak var trackName: UILabel!
    
    func updateCell(track : Track) {
        trackName.text = track.trackName
    }

}
