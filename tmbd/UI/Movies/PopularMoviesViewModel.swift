//
//  PopularMoviesViewModel.swift
//  tmbd
//
//  Created by Tarek El Ghoul on 28/10/2023.
//

import Resolver

class PopularMoviesViewModel: Subscribable {
    
    @Injected private var movieManager: MovieManagerProtocol
    
    @Mutable private(set) var movies: [Movie] = []
    private var moviesList: MovieList = MovieList(movies: [], page: 1, totalPages: 1)
    private var lastLoadedPage: Int = 1
    private var isLoadingNextPage = false
    
    let navigator: NavigatorProtocol
    
    init(navigator: NavigatorProtocol) {
        self.navigator = navigator
    }
    
    func onViewDidLoad() {
        getPopularMovies()
    }
    
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
    
    func onMovieTapped(movie: Movie) {
        navigator.toMovieDetail(movie)
    }
    
}
