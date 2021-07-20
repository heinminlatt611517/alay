//
//  NetworkingAgent.swift
//  Starter
//
//  Created by Admin on 26/06/2021.
//

import Foundation
import Alamofire

protocol MovieDBNetworkAgentProtocal {
    func getGenreList(completon: @escaping (MDBResult<GenreMovieLists>) -> Void)
}

struct MovieDBNetworkAgent {
    static let shared = MovieDBNetworkAgent()
    
    private init() {}
    
    func getMovieTariler(id: Int,completion: @escaping (MDBResult<MovieTrailerResopnse>) -> Void) {
        
//        let url = URL(string: "\(Constants.url)/movie/\(id)/videos?api_key=\(Constants.apiKey)")!
        AF.request(MDBEndpoint.trailerVideo(id))
            .responseDecodable(of: MovieTrailerResopnse.self) { response in
                switch response.result {
                case .failure(let error):
                    completion(.fail(handleError(response, error, MDBCommonResponseError.self)))
                case .success(let data):
                    completion(.success(data))
                }
            }
       }
    
    func getSimilarMovieList(id: Int,completion: @escaping (MDBResult<SimilarMovieListResopnse>) -> Void) {
        
//        let url = URL(string: "\(Constants.url)/movie/\(id)/similar?api_key=\(Constants.apiKey)")!
        AF.request(MDBEndpoint.similarMovie(id))
            .responseDecodable(of: SimilarMovieListResopnse.self) { response in
                switch response.result {
                case .failure(let error):
                    completion(.fail(error.localizedDescription))
                case .success(let data):
                    completion(.success(data))
                }
            }
       }
    
    func getActorDetailById(id: Int,completion: @escaping (MDBResult<ActorDetailResopnse>) -> Void) {
        
//        let url = URL(string: "\(Constants.url)/person/\(id)?api_key=\(Constants.apiKey)")!
        AF.request(MDBEndpoint.actorDetail(id))
            .responseDecodable(of: ActorDetailResopnse.self) { response in
                switch response.result {
                case .failure(let error):
                    completion(.fail(error.localizedDescription))
                case .success(let data):
                    completion(.success(data))
                }
            }
       }
    
    func getMovieCreditById(id: Int,completion: @escaping (MDBResult<MovieCreditResopnse>) -> Void) {
        
//        let url = URL(string: "\(Constants.url)/movie/\(id)/credits?api_key=\(Constants.apiKey)")!
        AF.request(MDBEndpoint.movieActors(id))
            .responseDecodable(of: MovieCreditResopnse.self) { response in
                switch response.result {
                case .failure(let error):
                    completion(.fail(error.localizedDescription))
                case .success(let data):
                    completion(.success(data))
                }
            }
       }
    
    func getSeriesDetailList(id: Int,completion: @escaping (MDBResult<SeriesDetailResopnse>) -> Void) {
        
//        let url = URL(string: "\(Constants.url)/tv/\(id)?api_key=\(Constants.apiKey)")!
        AF.request(MDBEndpoint.seriesDetails(id))
            .responseDecodable(of: SeriesDetailResopnse.self) { response in
                switch response.result {
                case .failure(let error):
                    completion(.fail(error.localizedDescription))
                case .success(let data):
                    completion(.success(data))
                }
            }
       }
    
    func getMovieDetailList(id: Int,completion: @escaping (MDBResult<MovieDetailResopnse>) -> Void) {
        
//        let url = URL(string: "\(Constants.url)/movie/\(id)?api_key=\(Constants.apiKey)")!
        AF.request(MDBEndpoint.movieDetails(id))
            .responseDecodable(of: MovieDetailResopnse.self) { response in
                switch response.result {
                case .failure(let error):
                    completion(.fail(error.localizedDescription))
                case .success(let data):
                    completion(.success(data))
                }
            }
       }
    
    func getActorList(completion: @escaping (MDBResult<ActorListResopnse>) -> Void) {
        
//        let url = URL(string: "\(Constants.url)/person/popular?api_key=\(Constants.apiKey)")!
        AF.request(MDBEndpoint.actors)
            .responseDecodable(of: ActorListResopnse.self) { response in
                switch response.result {
                case .failure(let error):
                    completion(.fail(error.localizedDescription))
                case .success(let data):
                    completion(.success(data))
                }
            }
       }
    
    func getPopularPeople(page: Int,completion: @escaping (MDBResult<ActorListResopnse>) -> Void) {
        
//        let url = URL(string: "\(Constants.url)/person/popular?page=\(page)&api_key=\(Constants.apiKey)")!
        AF.request(MDBEndpoint.popularActors(page))
            .responseDecodable(of: ActorListResopnse.self) { response in
                switch response.result {
                case .failure(let error):
                    completion(.fail(handleError(response, error, MDBCommonResponseError.self)))
                case .success(let data):
                    completion(.success(data))
                }
            }
       }
    
    
    func getTopRatedMovieList(completion: @escaping (MDBResult<MovieListResponse>) -> Void) {
        
//        let url = URL(string: "\(Constants.url)/movie/top_rated?api_key=\(Constants.apiKey)")!
        AF.request(MDBEndpoint.topRated)
            .responseDecodable(of: MovieListResponse.self) { response in
                switch response.result {
                case .failure(let error):
                    completion(.fail(error.localizedDescription))
                case .success(let data):
                    completion(.success(data))
                }
            }
       }
    
    func getMoreShowCaseList(page:Int,completion: @escaping (MDBResult<MovieListResponse>) -> Void) {
        
//        let url = URL(string: "\(Constants.url)/movie/top_rated?page=\(page)&api_key=\(Constants.apiKey)")!
        AF.request(MDBEndpoint.topRatedMovies(page))
            .responseDecodable(of: MovieListResponse.self) { response in
                switch response.result {
                case .failure(let error):
                    completion(.fail(error.localizedDescription))
                case .success(let data):
                    completion(.success(data))
                }
            }
       }
    
    func getPopularMovieList(completion: @escaping (MDBResult<MovieListResponse>) -> Void) {
        
//        let url = URL(string: "\(Constants.url)/movie/popular?api_key=\(Constants.apiKey)")!
        AF.request(MDBEndpoint.popularMovie)
            .responseDecodable(of: MovieListResponse.self) { response in
                switch response.result {
                case .failure(let error):
                    completion(.fail(error.localizedDescription))
                case .success(let upcomingMovieLists):
                    completion(.success(upcomingMovieLists))
                }
            }
       }
    
    func getPopularSeriesList(completion: @escaping (MDBResult<MovieListResponse>) -> Void) {
        
//        let url = URL(string: "\(Constants.url)/tv/popular?api_key=\(Constants.apiKey)")!
        AF.request(MDBEndpoint.popularTVSeries)
            .responseDecodable(of: MovieListResponse.self) { response in
                switch response.result {
                case .failure(let error):
                    completion(.fail(error.localizedDescription))
                case .success(let upcomingMovieLists):
                    completion(.success(upcomingMovieLists))
                }
            }
       }
    
    
    func getUpcomintMovieList(completion: @escaping (MDBResult<MovieListResponse>) -> Void) {
        
//        let url = URL(string: "\(Constants.url)/movie/upcoming?api_key=\(Constants.apiKey)")!
        AF.request(MDBEndpoint.upcomingMovie)
            .responseDecodable(of: MovieListResponse.self) { response in
                switch response.result {
                case .failure(let error):
                    completion(.fail(error.localizedDescription))
                case .success(let upcomingMovieLists):
                    completion(.success(upcomingMovieLists))
                }
            }
       }
    
    func getSearchMovie(query: String ,page: Int,completion: @escaping (MDBResult<MovieListResponse>) -> Void) {
       
//        let url = URL(string: "\(Constants.url)/search/movie?query=\(query)&page=\(page)&api_key=\(Constants.apiKey)")!
       
        AF.request(MDBEndpoint.searchMovie(page, query))
            .responseDecodable(of: MovieListResponse.self) { response in
                switch response.result {
                case .failure(let error):
                    completion(.fail(handleError(response, error, MDBCommonResponseError.self)))
                case .success(let data):
                    completion(.success(data))
                }
            }
       }
    
    func getGenreList(completion: @escaping (MDBResult<GenreMovieLists>) -> Void) {
        
//        let url = URL(string: "\(Constants.url)/genre/movie/list")!
        AF.request(MDBEndpoint.movieGenre)
            .responseDecodable(of: GenreMovieLists.self) { response in
                switch response.result {
                case .failure(let error):
                    completion(.fail(handleError(response, error, MDBCommonResponseError.self)))
                case .success(let genreMovieLists):
                    completion(.success(genreMovieLists))
                }
            }
       }
    
}


enum MDBResult<T> {
    case success(T)
    case fail(String)
}


/*
 network error
 -json serialization error
 -wrong url path
 -incorrect method
 -missing creditials
 
 */
 func handleError<T, E: MDBErrorModel>(_ response: DataResponse<T, AFError>,_ error: (AFError),_ errorBodyType: E.Type) -> String {
    var respBody : String = ""
    var serverErrorMessage: String?
    
    var errorBody: E?
    if let respData = response.data {
        respBody = String(data: respData, encoding: .utf8) ?? "empty response body"
        errorBody = try? JSONDecoder().decode(errorBodyType, from: respData)
        serverErrorMessage = errorBody?.message
    }
    
    /// extract debug info
    let respCode : Int = response.response?.statusCode ?? 0
    let sourchPath = response.request?.url?.absoluteString ?? "no url"
    
    //essential debug info
    print(
    """
        ====================
        URL
        -> \(sourchPath)

        Status
        -> \(respCode)

        Body
        -> \(respBody)

        Underlying Error
        -> \(error.underlyingError!)

        Error Description
        -> \(error.errorDescription!)
        =====================
        """
    )
    
    return serverErrorMessage ?? error.errorDescription ?? "undefined"
}


protocol MDBErrorModel: Decodable {
    var message: String { get }
}

class MDBCommonResponseError: MDBErrorModel {
    var message: String {
        return statusMessage
    }
    
    let statusMessage: String
    let statusCode: Int
    let success: Bool
    
    enum CodingKeys:String,CodingKey {
        case statusMessage = "status_message"
        case statusCode = "status_code"
        case success = "success"
    }
    
}
