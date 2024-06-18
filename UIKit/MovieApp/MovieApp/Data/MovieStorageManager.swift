//
//  MovieStorageManager.swift
//  MovieApp
//
//  Created by MadCow on 2024/6/18.
//

import Foundation
import SwiftData
import Combine

class MovieStorageManager {
    @Published var storageMovieInfo: [MovieInfoStorage] = []
    private var container: ModelContainer?
    private var context: ModelContext?
    private var cancellable: Cancellable?
    var tableReloadDelegate: ReloadMovieTableDelegate?
    
    init() {
        cancellable?.cancel()
        cancellable = self.$storageMovieInfo.sink { [weak self] _ in
            guard let self = self else { return }
            tableReloadDelegate?.reloadTableView()
        }
        
        do {
            self.container = try ModelContainer(for: MovieInfoStorage.self)
            guard let container = self.container else {
                return
            }
            self.context = ModelContext(container)
            
            DispatchQueue.main.async {
                self.loadMovies()
            }
            
        } catch {
            print("WeatherMainViewModel container load error > \(error.localizedDescription)")
        }
    }
    
    func loadMovies() {
        let descriptor = FetchDescriptor<MovieInfoStorage>(sortBy: [SortDescriptor<MovieInfoStorage>(\.releaseDate)])
        guard let ctx = self.context else {
            print("context nil error")
            return
        }
        
        do {
            let data = try ctx.fetch(descriptor)
            storageMovieInfo = data
        } catch {
            storageMovieInfo = []
        }
    }
    
    func saveMovie(movie: MovieInfoStorage) {
        guard let context = self.context else { return }
        context.insert(movie)
        self.loadMovies()
    }
    
    func deleteMovie(movies: [MovieInfoStorage]) {
        guard let context = self.context else { return }
        if movies.count > 0 {
            movies.forEach{ context.delete($0) }
        }
        self.loadMovies()
    }
}
