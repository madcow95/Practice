//
//  BookmarkMovieViewModel.swift
//  MovieApp
//
//  Created by MadCow on 2024/6/18.
//

import Foundation
import SwiftData
import Combine

class BookmarkMovieViewModel {
    private var container: ModelContainer?
    private var context: ModelContext?
    private var cancellable: Cancellable?
    var tableReloadDelegate: ReloadBookmarkTableDelegate?
    let storeManager = MovieStorageManager()
    
    init() {
        cancellable?.cancel()
        cancellable = self.storeManager.$storageMovieInfo.sink { [weak self] _ in
            guard let self = self else { return }
            tableReloadDelegate?.reloadBookmarkTable()
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
            storeManager.storageMovieInfo = data
        } catch {
            storeManager.storageMovieInfo = []
        }
    }
    
    func saveMovie(movie: MovieInfoStorage) {
        guard let context = self.context else { return }
        context.insert(movie)
        self.loadMovies()
    }
    
    func deleteMovie(movie: MovieInfoStorage) {
        guard let context = self.context else { return }
        
        context.delete(movie)
        self.loadMovies()
    }
    
    func deleteMovieBy(id: Int) {
        if let targetMovie = self.storeManager.storageMovieInfo.filter({ $0.id == id }).first {
            deleteMovie(movie: targetMovie)
        }
    }
}
