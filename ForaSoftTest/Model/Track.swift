//
//  Track.swift
//  ForaSoftTest
//
//  Created by Руслан Ахриев on 13.09.2018.
//  Copyright © 2018 Руслан Ахриев. All rights reserved.
//

import Foundation

struct TrackJSON : Codable {
    var resultsCount : Int?
    var results : [TrackInfo]
}

struct TrackInfo : Codable {
    var trackName : String?
}

class Track {
    var trackName: String

    init(trackName: String) {
        self.trackName = trackName
    }
}

