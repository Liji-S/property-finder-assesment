//
//  NetworkService.swift
//  Tahudu
//

import Foundation

enum NetworkError: LocalizedError {
    case invalidResponse
    case failedStatusCode(Int)

    var errorDescription: String? {
        switch self {
        case .invalidResponse:
            return "Invalid server response."
        case .failedStatusCode(let statusCode):
            return "Request failed with status code \(statusCode)."
        }
    }
}

protocol NetworkServicingProtocol {
    func fetch<T: Decodable>(_ type: T.Type, from url: URL) async throws -> T
}

struct NetworkService: NetworkServicingProtocol {
    private let session: URLSession
    private let decoder: JSONDecoder

    init(session: URLSession = .shared, decoder: JSONDecoder = .propertyFinder) {
        self.session = session
        self.decoder = decoder
    }

    func fetch<T: Decodable>(_ type: T.Type, from url: URL) async throws -> T {
        let (data, response) = try await session.data(from: url)

        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }

        guard 200..<300 ~= httpResponse.statusCode else {
            throw NetworkError.failedStatusCode(httpResponse.statusCode)
        }

        return try decoder.decode(type, from: data)
    }
}

extension JSONDecoder {
    static let propertyFinder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }()
}
