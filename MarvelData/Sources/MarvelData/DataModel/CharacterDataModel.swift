import Foundation

public struct CharacterDataModel: Decodable, Equatable {
    public let id: Int
    public let name: String
    public let thumbnail: Thumbnail
}
