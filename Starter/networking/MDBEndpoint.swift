//
//  MDBEndpoint.swift
//  Starter
//
//  Created by Admin on 08/07/2021.
//

import Foundation
import Alamofire

enum MDBEndpoint: URLConvertible {
    case searchMovie(_ page: Int,_ query: String)
    case actorTVCredit(_ id: Int)
    case actorImages(_ id: Int)
    case actorDetail(_ id: Int)
    case trailerVideo(_ id: Int)
    case similarMovie(_ id: Int)
    case movieActors(_ id: Int)
    case movieDetails(_ id: Int)
    case seriesDetails(_ id: Int)
    case popularActors(_ page: Int)
    case topRatedMovies(_ page: Int)
    case topRated
    case movieGenre
    case popularTVSeries
    case upcomingMovie
    case popularMovie
    case actors
    
    private var baseUrl: String {
        return Constants.url
    }
    
    func asURL() throws -> URL {
        return url
    }
    
    var url: URL {
        let urlComponents = NSURLComponents(string: baseUrl.appending(apiPath))
        if urlComponents?.queryItems == nil {
            urlComponents?.queryItems = []
        }
        
        urlComponents?.queryItems?.append(contentsOf: [URLQueryItem(name: "api_key", value: Constants.apiKey)])
        
        return urlComponents!.url!
    }
    
    // api url
    private var apiPath: String {
        switch self {
        case .upcomingMovie:
            return "/movie/upcoming"
        case .popularMovie:
            return "/movie/popular"
        case .searchMovie(let page, let query):
            return "/search/movie?query=\(query)&page=\(page)"
        case .actorTVCredit(let id):
            return "/person/\(id)/tv_credits"
        case .actorImages(let id):
            return "/person/\(id)/images"
        case .actorDetail(let id):
            return "/person/\(id)"
        case .trailerVideo(let id):
            return "/movie/\(id)/videos"
        case .similarMovie(let id):
            return "/movie/\(id)/similar"
        case .movieActors(let id):
            return "/movie/\(id)/credits"
        case .movieDetails(let id):
            return "/movie/\(id)"
        case .seriesDetails(let id):
            return "/tv/\(id)"
        case .popularActors(let page):
            return "/person/popular?page=\(page)"
        case .topRatedMovies(let page):
            return "/movie/top_rated?page=\(page)"
        case .movieGenre:
            return "/genre/movie/list"
        case .popularTVSeries:
            return "/tv/popular"
        case .topRated:
            return "/movie/top_rated"
        case .actors:
            return "/person/popular"
    }
    
   }
    
}
