//
//  ViewModel.swift
//  Walmart test
//
//  Created by Nikita Baksheev on 6/19/25.
//

import Foundation

struct CountryCellViewModel {
    let nameRegion: String
    let code: String
    let capital: String
    
    init(country: Country) {
        self.nameRegion = "\(country.name), \(country.region)"
        self.code = country.code
        self.capital = country.capital
    }
}

@MainActor
class CountryListViewModel {
    private let service = CountryService()
    
    private(set) var allCountries: [Country] = []
    private(set) var filteredCountries: [CountryCellViewModel] = []
    
    func loadCountries() async throws {
        allCountries = try await service.fetchCountries()
        filteredCountries = allCountries.map { CountryCellViewModel(country: $0) }
    }
    
    func filterCountries(with searchText: String) {
        if searchText.isEmpty {
            filteredCountries = allCountries.map { CountryCellViewModel(country: $0) }
        } else {
            filteredCountries = allCountries
                .filter {
                    $0.name.localizedCaseInsensitiveContains(searchText) ||
                    $0.capital.localizedCaseInsensitiveContains(searchText)
                }
                .map { CountryCellViewModel(country: $0) }
        }
    }
}
