//
//  ContentView.swift
//  Movies
//
//  Created by Foundation on 2022. 02. 14..
//

import SwiftUIInfiniteList
import SwiftUI

protocol MoviesScreenViewModelProtocol: ObservableObject {
    var isLoading: Bool { get set }
    var movies: [MovieVM] { get set }
    
    func loadMore()
}

struct MoviesScreen<ViewModel: MoviesScreenViewModelProtocol>: View {
    @ObservedObject var viewModel: ViewModel

    var body: some View {
        NavigationView {
            InfiniteList(
                data: $viewModel.movies,
                isLoading: $viewModel.isLoading,
                loadingView: ProgressView(),
                loadMore: viewModel.loadMore) { item in
                    NavigationLink(destination: destinationView(using: item)) {
                        MovieListItem(movie: item)
                            .padding(.trailing, 8)
                    }
                    .padding(.trailing, 16)
                    .listRowInsets(EdgeInsets())
                }
            .navigationTitle("Movies")
        }
        .navigationViewStyle(.stack)
    }

    func destinationView(using movie: MovieVM) -> some View {
        MovieDetailsScreen(viewModel: MovieDetailsScreenViewModel(movie: movie))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MoviesScreen(viewModel: MockViewModel())
                .preferredColorScheme(.light)
            MoviesScreen(viewModel: MockViewModel())
                .preferredColorScheme(.dark)
        }
    }
}
