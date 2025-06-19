//
//  CountryService.swift
//  Walmart test
//
//  Created by Nikita Baksheev on 6/19/25.
//

import Foundation

class CountryService {
    private let downloader: DataDownloader
    private let urlString = "https://gist.githubusercontent.com/peymano-wmt/32dcb892b06648910ddd40406e37fdab/raw/db25946fd77c5873b0303b858e861ce724e0dcd0/countries.json"

    init(downloader: DataDownloader = NetworkManager()) {
        self.downloader = downloader
    }

    func fetchCountries() async throws -> [Country] {
        guard let url = URL(string: urlString) else {
            throw NetworkError.invalidURL
        }

        let data = try await downloader.download(from: url)
        do {
            return try JSONDecoder().decode([Country].self, from: data)
        } catch {
            throw NetworkError.decodingError(error)
        }
    }
}
