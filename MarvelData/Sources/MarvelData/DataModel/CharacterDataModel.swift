import Foundation

public struct CharacterDataModel: Decodable {
    public let id: Int
    public let name: String
    public let thumbnail: Thumbnail
}
