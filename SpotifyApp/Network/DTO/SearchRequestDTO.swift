import Foundation

struct SearchRequestDTO: Encodable {
    enum SearchType: String, Codable, CaseIterable {
        case album
        case artist
        case playlist
        case track
    }

    enum CodingKeys: String, CodingKey {
        case q
        case type
    }

    let query: String
    let types: [SearchType]

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(query, forKey: .q)
        let joinedTypes = types.map { $0.rawValue }.joined(separator: ",")
        try container.encode(joinedTypes, forKey: .type)
    }
}
