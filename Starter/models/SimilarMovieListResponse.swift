
// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let similarMovieListResopnse = try? newJSONDecoder().decode(SimilarMovieListResopnse.self, from: jsonData)

import Foundation

// MARK: - SimilarMovieListResopnse
struct SimilarMovieListResopnse: Codable {
    let page: Int?
    let results: [SimilarMovieResult]?
    let totalPages, totalResults: Int?

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - Result
struct SimilarMovieResult: Codable {
    let backdropPath: String?
    let genreIDS: [Int]?
    let originalLanguage: String?
    let originalTitle, posterPath: String?
    let video: Bool?
    let voteAverage: Double?
    let voteCount: Int?
    let overview, releaseDate: String?
    let id: Int?
    let title: String?
    let adult: Bool?
    let popularity: Double?

    enum CodingKeys: String, CodingKey {
        case backdropPath = "backdrop_path"
        case genreIDS = "genre_ids"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case posterPath = "poster_path"
        case video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case overview
        case releaseDate = "release_date"
        case id, title, adult, popularity
    }
    
    func convertedToSimilarMovieInfo()-> MovieResult {
        return MovieResult(adult: self.adult, backdropPath: self.backdropPath, genreIDS: self.genreIDS, id: self.id, originalLanguage: self.originalLanguage, originalTitle: self.originalTitle, originalName: self.originalTitle, overview: self.originalTitle, popularity: self.popularity, posterPath: self.posterPath, releaseDate: self.releaseDate, title: self.title, video: self.video, voteAverage: self.voteAverage, voteCount: self.voteCount)
    }
}


