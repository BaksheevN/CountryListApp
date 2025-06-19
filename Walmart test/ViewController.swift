//
//  ViewController.swift
//  Walmart test
//
//  Created by Nikita Baksheev on 6/19/25.
//

import UIKit

class CountryListViewController: UIViewController {
    
    private let tableView = UITableView()
    private let searchController = UISearchController(searchResultsController: nil)
    private let viewModel = CountryListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Countries"
        view.backgroundColor = .systemBackground
        setupTableView()
        setupSearchController()
        
        Task {
            await loadCountries()
        }
    }
    
    private func setupTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(CountryCell.self, forCellReuseIdentifier: "CountryCell")
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 60
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setupSearchController() {
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Search by name or capital"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    private func loadCountries() async {
        do {
            try await viewModel.loadCountries()
            tableView.reloadData()
        } catch {
            showError(error)
        }
    }
    
    private func showError(_ error: Error) {
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}

extension CountryListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.filteredCountries.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CountryCell", for: indexPath) as? CountryCell else {
            return UITableViewCell()
        }
        cell.configure(with: viewModel.filteredCountries[indexPath.row])
        return cell
    }
}

extension CountryListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        viewModel.filterCountries(with: searchController.searchBar.text ?? "")
        tableView.reloadData()
    }
}


