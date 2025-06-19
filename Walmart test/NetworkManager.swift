//
//  NetworkManager.swift
//  Walmart test
//
//  Created by Nikita Baksheev on 6/19/25.
//

import Foundation

class NetworkManager: DataDownloader {
    func download(from url: URL) async throws -> Data {
        do {
            let (data, response) = try await URLSession.shared.data(from: url)

            if let httpResponse = response as? HTTPURLResponse, !(200...299).contains(httpResponse.statusCode) {
                throw NetworkError.serverError(statusCode: httpResponse.statusCode)
            }

            guard !data.isEmpty else {
                throw NetworkError.noData
            }

            return data
        } catch let error as NetworkError {
            throw error
        } catch {
            throw NetworkError.underlying(error)
        }
    }
}

protocol DataDownloader {
    func download(from url: URL) async throws -> Data
}

enum NetworkError: Error, LocalizedError {
    case invalidURL
    case noData
    case decodingError(Error)
    case serverError(statusCode: Int)
    case underlying(Error)

    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "The URL provided was invalid."
        case .noData:
            return "No data was received from the server."
        case .decodingError(let error):
            return "Failed to decode the response: \(error.localizedDescription)"
        case .serverError(let statusCode):
            return "Server returned an error: \(statusCode)"
        case .underlying(let error):
            return error.localizedDescription
        }
    }
}


