//
//  PopularMoviesViewModel.swift
//  tmbd
//
//  Created by Tarek El Ghoul on 28/10/2023.
//

import Resolver

class PopularMoviesViewModel: Subscribable {
    
    
    // MARK: - Private properties
    
    private var moviesList: MovieList = MovieList(movies: [], page: 1, totalPages: 1)
    @Mutable private(set) var movies: [Movie] = []
    private var lastLoadedPage: Int = 1
    private var isLoadingNextPage = false
    private let navigator: NavigatorProtocol
    
    // MARK: - Dependencies
   
    @Injected private var movieManager: MovieManagerProtocol
    
    init(navigator: NavigatorProtocol) {
        self.navigator = navigator
    }
    
    // MARK: - Lifecycle
    
    func onViewDidLoad() {
        getPopularMovies()
    }
    
    // MARK: - Public functions
    
    func getPopularMovies() {
        sub(movieManager.getMovies(atPage: lastLoadedPage).subscribe(
            onSuccess: { [weak self] movieList in
                self?.moviesList = movieList
                self?.movies.append(contentsOf: movieList.movies)
                self?.isLoadingNextPage = false
            },
            onFailure: { error in
                self.isLoadingNextPage = false
                print("error:", error)
            }))
    }
    
    func onLoadNextPage() {
        loadNextPage()
    }
    
    func updateAndCheckPage() -> Bool {
        if lastLoadedPage <= moviesList.totalPages {
            lastLoadedPage += 1
            return true
        } else {
            return false
        }
    }
    
    func loadNextPage() {
        guard !isLoadingNextPage, updateAndCheckPage() else {
            return
        }
        
        isLoadingNextPage = true
        getPopularMovies()
    }
    
    // MARK: - Navigation
    
    func onMovieTapped(movie: Movie) {
        navigator.toMovieDetail(movie)
    }
    
}
