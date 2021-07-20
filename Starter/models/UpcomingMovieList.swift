// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let upcomingMovieLists = try? newJSONDecoder().decode(UpcomingMovieLists.self, from: jsonData)

import Foundation

// MARK: - UpcomingMovieLists
struct MovieListResponse: Codable {
    let dates: Dates?
    let page: Int?
    let results: [MovieResult]?
    let totalPages, totalResults: Int?

    enum CodingKeys: String, CodingKey {
        case dates, page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - Dates
struct Dates: Codable {
    let maximum, minimum: String?
}

// MARK: - Result
struct MovieResult: Codable,Hashable {
    let adult: Bool?
    let backdropPath: String?
    let genreIDS: [Int]?
    let id: Int?
    let originalLanguage: String?
    let originalTitle,originalName, overview: String?
    let popularity: Double?
    let posterPath, releaseDate, title: String?
    let video: Bool?
    let voteAverage: Double?
    let voteCount: Int?

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genreIDS = "genre_ids"
        case id
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case originalName = "original_name"
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}

enum OriginalLanguage: String, Codable {
    case en = "en"
    case es = "es"
}


// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let genreMovieLists = try? newJSONDecoder().decode(GenreMovieLists.self, from: jsonData)

import Foundation

// MARK: - GenreMovieLists
struct GenreMovieLists: Codable {
    let genres: [MovieGenre]?
}

// MARK: - Genre
public struct MovieGenre: Codable {
   public let id: Int?
    public let name: String?
    
    enum CodingKeys: String,CodingKey {
        case id
        case name = "name"
    }
    
    func convertToGenreVO()-> GenreVO {
        let vo = GenreVO(name: name ?? "", isSelected: false, id: id ?? 0)
        
        return vo
    }
}


