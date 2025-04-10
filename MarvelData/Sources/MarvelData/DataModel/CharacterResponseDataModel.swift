import Foundation

public struct CharacterDataContainer: Decodable, Equatable {
    public let count: Int
    public let limit: Int
    public let offset: Int
    public let total: Int
    public let characters: [CharacterDataModel]
    
    enum CodingKeys: String, CodingKey {
        case data
        case count, limit, offset, total, characters = "results"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let data = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .data)
        self.count = try data.decode(Int.self, forKey: .count)
        self.limit = try data.decode(Int.self, forKey: .limit)
        self.offset = try data.decode(Int.self, forKey: .offset)
        self.total = try data.decode(Int.self, forKey: .total)
        self.characters = try data.decode([CharacterDataModel].self, forKey: .characters)
    }
}
