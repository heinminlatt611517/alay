// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let movieTrailerResopnse = try? newJSONDecoder().decode(MovieTrailerResopnse.self, from: jsonData)

import Foundation

// MARK: - MovieTrailerResopnse
struct MovieTrailerResopnse: Codable {
    let id: Int?
    let results: [MovieTrailer]?
}

// MARK: - Result
struct MovieTrailer: Codable {
    let id, iso639_1, iso3166_1, key: String?
    let name, site: String?
    let size: Int?
    let type: String?

    enum CodingKeys: String, CodingKey {
        case id
        case iso639_1 = "iso_639_1"
        case iso3166_1 = "iso_3166_1"
        case key, name, site, size, type
    }
}
