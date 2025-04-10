import Foundation

public protocol APIClientProtocol {
    func getHeroes(offset: Int) async throws -> CharacterDataContainer
    func getHeroeDetail(heroeID: Int) async throws -> CharacterDataModel
    var urlSession: NetworkSession { get }
}

public final class APIClient: APIClientProtocol {
    enum Constant {
        static let publicKey = "d575c26d5c746f623518e753921ac847"
        static let limitPerPage = 20
        static let endpoint = "https://gateway.marvel.com:443/v1/public/characters"
    }
    
    enum InfoPlistKey: String {
        case privateKey = "MARVEL_API_PRIVATE_KEY"
    }
    
    enum URLParameter: String {
        case apikey
        case ts
        case hash
        case limit
        case offset
    }
    
    public let urlSession: NetworkSession
    
    public init(urlSession: NetworkSession) {
        self.urlSession = urlSession
    }
    
    public func getHeroes(offset: Int) async throws -> CharacterDataContainer {
        let ts = String(Int(Date().timeIntervalSince1970))
        let privateKey = Bundle.main.object(forInfoDictionaryKey: InfoPlistKey.privateKey.rawValue) ?? "test key"
        let publicKey = Constant.publicKey
        let hash = "\(ts)\(privateKey)\(publicKey)".md5
        let parameters: [String: String] = [URLParameter.apikey.rawValue: publicKey,
                                            URLParameter.ts.rawValue: ts,
                                            URLParameter.hash.rawValue: hash,
                                            URLParameter.limit.rawValue: "\(Constant.limitPerPage)",
                                            URLParameter.offset.rawValue: "\(offset)"
        ]
        
        let endpoint = Constant.endpoint
        var urlComponent = URLComponents(string: endpoint)
        urlComponent?.queryItems = parameters.map { (key, value) in
            URLQueryItem(name: key, value: value)
        }
        guard let url = urlComponent?.url else {
            throw NetworkingError.invalidURL
        }
        let urlRequest = URLRequest(url: url)
        
        let (data, _) = try await urlSession.data(for: urlRequest)
        let dataModel = try JSONDecoder().decode(CharacterDataContainer.self, from: data)
        #if DEBUG
            print(dataModel)
        #endif
        return dataModel
    }
    
    public func getHeroeDetail(heroeID: Int) async throws -> CharacterDataModel {
        let ts = String(Int(Date().timeIntervalSince1970))
        let privateKey = Bundle.main.object(forInfoDictionaryKey: InfoPlistKey.privateKey.rawValue) ?? "test key"
        let publicKey = Constant.publicKey
        let hash = "\(ts)\(privateKey)\(publicKey)".md5
        let parameters: [String: String] = [URLParameter.apikey.rawValue: publicKey,
                                            URLParameter.ts.rawValue: ts,
                                            URLParameter.hash.rawValue: hash]
        let endpoint = Constant.endpoint+"/\(heroeID)"
        var urlComponent = URLComponents(string: endpoint)
        urlComponent?.queryItems = parameters.map { (key, value) in
            URLQueryItem(name: key, value: value)
        }
        guard let url = urlComponent?.url else {
            throw NetworkingError.invalidURL
        }
        let urlRequest = URLRequest(url: url)
        let (data, _) = try await urlSession.data(for: urlRequest)
        let dataModel = try JSONDecoder().decode(CharacterDataContainer.self, from: data)
        #if DEBUG
            print(dataModel)
        #endif
        // There is only one character in the response
        let detailedCharacter = dataModel.characters.first!
        return detailedCharacter
    }
}

enum NetworkingError: Error {
    case invalidURL
}

public protocol NetworkSession {
    func data(for url: URLRequest) async throws -> (Data, URLResponse)
}

extension URLSession : NetworkSession {}
    
