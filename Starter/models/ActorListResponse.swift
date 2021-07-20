// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let actorListResopnse = try? newJSONDecoder().decode(ActorListResopnse.self, from: jsonData)

import Foundation

// MARK: - ActorListResopnse
struct ActorListResopnse: Codable {
    let page: Int?
    let results: [ActorResult]?
    let totalPages, totalResults: Int?

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - Result
struct ActorResult: Codable {
    let adult: Bool?
    let gender, id: Int?
    let knownFor: [KnownFor]?
    let knownForDepartment: String?
    let name: String?
    let popularity: Double?
    let profilePath: String?

    enum CodingKeys: String, CodingKey {
        case adult, gender, id
        case knownFor = "known_for"
        case knownForDepartment = "known_for_department"
        case name, popularity
        case profilePath = "profile_path"
    }
}

// MARK: - KnownFor
struct KnownFor: Codable {
    let backdropPath, firstAirDate: String?
    let genreIDS: [Int]?
    let id: Int?
    let mediaType: MediaType?
    let name: String?
    let originCountry: [String]?
    let originalLanguage: String?
    let originalName, overview, posterPath: String?
    let voteAverage: Double?
    let voteCount: Int?
    let adult: Bool?
    let originalTitle, releaseDate, title: String?
    let video: Bool?

    enum CodingKeys: String, CodingKey {
        case backdropPath = "backdrop_path"
        case firstAirDate = "first_air_date"
        case genreIDS = "genre_ids"
        case id
        case mediaType = "media_type"
        case name
        case originCountry = "origin_country"
        case originalLanguage = "original_language"
        case originalName = "original_name"
        case overview
        case posterPath = "poster_path"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case adult
        case originalTitle = "original_title"
        case releaseDate = "release_date"
        case title, video
    }
}

enum MediaType: String, Codable {
    case movie = "movie"
    case tv = "tv"
}

enum OriginalLanguage2: String, Codable {
    case de = "de"
    case en = "en"
    case es = "es"
    case ja = "ja"
    case ko = "ko"
    case ru = "ru"
    case tr = "tr"
}

enum KnownForDepartment: String, Codable {
    case acting = "Acting"
}
