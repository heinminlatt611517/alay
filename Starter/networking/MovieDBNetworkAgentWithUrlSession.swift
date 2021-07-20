//
//  MovieDBNetworkAgentProtocal.swift
//  Starter
//
//  Created by Admin on 09/07/2021.
//

import Foundation

class MovieDBNetworkAgentWithUrlSession: MovieDBNetworkAgentProtocal {
    
    static let shared = MovieDBNetworkAgentWithUrlSession()
    
    private init() { }
    
    func getGenreList(completon: @escaping (MDBResult<GenreMovieLists>) -> Void) {
        let url = URL(string: "https://api.themoviedb.org/3/genre/movie/list?api_key=46ece7256a33d62d8ea238b215965aea")!
        
        var urlrequest = URLRequest(url: url)
        urlrequest.httpMethod = "GET"
        urlrequest.allHTTPHeaderFields = ["key1": "value1","key2": "value2"]
        urlrequest.setValue("key1", forHTTPHeaderField: "value1")
        
        let session = URLSession.shared
        
        session.dataTask(with: url) { (data, response, error) in
            let genreList: GenreMovieLists = try! JSONDecoder().decode(GenreMovieLists.self, from: data!)
            
            completon(.success(genreList))
            
                }.resume()
    }
    
    
}
