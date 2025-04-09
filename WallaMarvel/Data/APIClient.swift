import Foundation

protocol APIClientProtocol {
    func getHeroes(completionBlock: @escaping (CharacterDataContainer) -> Void)
    func getHeroeDetail(heroeID: Int) async throws -> CharacterDataModel
    var urlSession: URLSession { get }
}

final class APIClient: APIClientProtocol {
    enum Constant {
        static let privateKey = "188f9a5aa76846d907c41cbea6506e4cc455293f"
        static let publicKey = "d575c26d5c746f623518e753921ac847"
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
    
    var urlSession: URLSession { URLSession.shared }
    
    init() { }
    
    func getHeroes(completionBlock: @escaping (CharacterDataContainer) -> Void) {
        let ts = String(Int(Date().timeIntervalSince1970))
        let privateKey = Constant.privateKey
        let publicKey = Constant.publicKey
        let hash = "\(ts)\(privateKey)\(publicKey)".md5
        let parameters: [String: String] = ["apikey": publicKey,
                                            "ts": ts,
                                            "hash": hash]
        
        let endpoint = "https://gateway.marvel.com:443/v1/public/characters"
        var urlComponent = URLComponents(string: endpoint)
        urlComponent?.queryItems = parameters.map { (key, value) in
            URLQueryItem(name: key, value: value)
        }
        
        let urlRequest = URLRequest(url: urlComponent!.url!)
        
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            let dataModel = try! JSONDecoder().decode(CharacterDataContainer.self, from: data!)
            completionBlock(dataModel)
            print(dataModel)
        }.resume()
    }
    
    func getHeroeDetail(heroeID: Int) async throws -> CharacterDataModel {
        let ts = String(Int(Date().timeIntervalSince1970))
        // This should break if the API key is not available in xcconfig file
        let privateKey = Bundle.main.object(forInfoDictionaryKey: InfoPlistKey.privateKey.rawValue) as! String
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
