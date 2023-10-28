//
//  PopularMoviesViewController.swift
//  tmbd
//
//  Created by Tarek El Ghoul on 28/10/2023.
//

import UIKit
import Resolver

class PopularMoviesViewController: UIViewController, Subscribable {
    
    // MARK: IBOutles
    
    @IBOutlet private weak var searchBar: UISearchBar!
    @IBOutlet weak private var tableView: UITableView!
    
    // MARK: Private properties
    
    private lazy var viewModel: PopularMoviesViewModel = PopularMoviesViewModel(navigator: Resolver.resolve(args: self))
    private let movieCellIdentifier = "MovieCell"
    private var movies: [Movie] = []
    private var filteredData: [Movie] = []
    
    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        observeViewData()
        viewModel.onViewDidLoad()
        setupTableView()
        searchBar.delegate = self
    }
    
    // MARK: Private functions
    
    private func setupTableView() {
        let nib = UINib(nibName: movieCellIdentifier, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: movieCellIdentifier)
        tableView.contentInsetAdjustmentBehavior = .never
    }
    
    private func observeViewData() {
        sub(viewModel.$movies.subscribe(onNext: { [weak self] movies in
            self?.filteredData = movies
            self?.updateTableView(with: movies)
        }))
    }
    
    private func updateTableView(with movies: [Movie]) {
        self.movies = movies
        tableView.reloadData()
    }
}

// MARK: - UITableViewDataSource

extension PopularMoviesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: movieCellIdentifier, for: indexPath) as! MovieCell
        cell.configure(with: filteredData[indexPath.row])
        return cell
        
    }
}

// MARK: - UITableViewDelegate

extension PopularMoviesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == movies.count - 1 {
            viewModel.onLoadNextPage()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.onMovieTapped(movie: filteredData[indexPath.row])
    }

}

// MARK: - UISearchBarDelegate

extension PopularMoviesViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            if searchText.isEmpty {
                filteredData = movies
            } else {
                filteredData = movies.filter { $0.title.lowercased().contains(searchText.lowercased()) }
            }
            tableView.reloadData()
        }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        filteredData = movies
        searchBar.text = ""
        tableView.reloadData()
    }
}
