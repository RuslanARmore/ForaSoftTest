//
//  WebService.swift
//  ForaSoftTest
//
//  Created by Руслан Ахриев on 13.09.2018.
//  Copyright © 2018 Руслан Ахриев. All rights reserved.
//

import Foundation

class WebService {
    
    let itunes_api = "https://itunes.apple.com/search?entity=album&attribute=albumTerm&offset=0&limit=100&term="
    let itunes_songs_api = "https://itunes.apple.com/lookup?entity=song&id="

    static let instance = WebService()
    
    func getAlbums (searchRequest: String, complition: @escaping ([Album])->()) {
        var albums = [Album]()
        let searchString = searchRequest.replacingOccurrences(of: " ", with: "+")
        let url = URL(string: "\(itunes_api)\(searchString)")
        let task = URLSession.shared
        task.dataTask(with: url!) { (data, response, error) in
            if let data = data {
                    let album = try! JSONDecoder().decode(AlbumJSON.self, from: data)
                    
                    for albumInfo in album.results! {
                        
                        guard let artistName = albumInfo.artistName else {return}
                        guard let artworkUrl100 = albumInfo.artworkUrl100 else {return}
                        guard let collectionId = albumInfo.collectionId else {return}
                        guard let collectionName = albumInfo.collectionName else {return}
                        guard let country = albumInfo.country else {return}
                        guard let primaryGenreName = albumInfo.primaryGenreName else {return}
                        guard let releaseDate = albumInfo.releaseDate else {return}
                       
                            let releaseDateFormatted = releaseDate.prefix(4)

                            let albumInstance = Album(artistName: artistName, artworkUrl100: artworkUrl100, collectionId: collectionId, collectionName: collectionName, country: country, primaryGenreName: primaryGenreName, releaseDate: String(releaseDateFormatted))
                      
                            albums.append(albumInstance)
                    }
            complition(albums)
            }
        }.resume()
    }
    
    func getAlbumTracks (collectionId: Int, complition: @escaping ([Track]) -> ()) {
        var tracksList = [Track]()
        let url = URL(string: "\(itunes_songs_api)\(collectionId)")
        let session = URLSession.shared
        session.dataTask(with: url!) { (data, response, error) in
            if let data = data {
                    let tracks = try! JSONDecoder().decode(TrackJSON.self, from: data)
                    for track in tracks.results {
                        if track.trackName != nil {
                            tracksList.append(Track(trackName: track.trackName!))
                        }
                    }
                    complition(tracksList)
            }
        }.resume()
    }
}
