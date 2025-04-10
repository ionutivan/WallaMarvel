import Testing
import Foundation
@testable import MarvelData

final class MockSession: NetworkSession {
    let mockData: Data
    let mockResponse: URLResponse

    init(data: Data, response: URLResponse) {
        self.mockData = data
        self.mockResponse = response
    }

    func data(for url: URLRequest) async throws -> (Data, URLResponse) {
        return (mockData, mockResponse)
    }
}

@Test func parsingAndReturnedDataIsCorrect() async throws {
    guard let path = Bundle.module.url(forResource: "Data", withExtension: "json") else {
        Issue.record("Missing file: Data.json")
                return
            }
    let expectedData = try! Data(contentsOf: path)
    let mockResponse = HTTPURLResponse(
        url: URL(string: "https://test.com")!,
        statusCode: 200,
        httpVersion: nil,
        headerFields: nil)!

    let mockSession = MockSession(data: expectedData, response: mockResponse)
    let service = APIClient(urlSession: mockSession)
    let decoder = JSONDecoder()
    let expectedHeroes = try decoder.decode(CharacterDataContainer.self, from: expectedData)
    let data = try await service.getHeroes(offset: 0)
    #expect(data == expectedHeroes)
}
