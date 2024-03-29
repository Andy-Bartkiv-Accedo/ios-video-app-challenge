//
//  MediaViewModel.swift
//  swift-splash-screen
//
//  Created by Andy Bartkiv on 2023-11-17.
//

import Foundation

@MainActor
final class MediaViewModel: ObservableObject {
    
    let client = MediaHTTPClient()

    private var fetchedData: [MediaItem] = []
    @Published var mediaLibrary: [MediaItem] = []
    @Published var searchResults: [MediaItem] = []
    @Published var favotiteIds: [Int] = []
    @Published private(set) var isRefreshing = false
    
    func toggleFavorite(itemId: Int) {
        if (self.favotiteIds.contains(itemId)) {
            if let index = self.favotiteIds.firstIndex(of: itemId) {
                self.favotiteIds.remove(at: index)
            }
        } else {
            self.favotiteIds.append(itemId)
        }
    }

    func getRandom(qty: Int = 5, mediaType: String = "all") {
        if (self.fetchedData.count == 0) {
            return
        }
        var lib = (mediaType == "all")
            ? self.fetchedData
            : self.fetchedData.filter({ $0.type == mediaType })
        lib.shuffle()
        self.mediaLibrary = Array(lib[..<min(qty, lib.count)])
    }
    
    func searchLibrary(query: String) {
        self.searchResults = self.fetchedData.filter({
//            $0.title == query || $0.name == query
            var itemName = ""
            itemName = $0.title != nil ? $0.title! : itemName
            itemName = $0.name != nil ? $0.name! : itemName
            return itemName.containsIgnoringCase(find: query)
        })
    }
    
    func filterLibrary(mediaType: String) {
        self.mediaLibrary = self.fetchedData.filter({ $0.type == mediaType })
    }
    
    func filterFavourites() {
        self.mediaLibrary = self.fetchedData.filter({ self.favotiteIds.contains($0.id) })
    }
    
    func updateFavorites(newFavorites: [Int] = []) {
        self.favotiteIds = newFavorites;
    }
    
    func updateLibrary() {
        self.mediaLibrary = self.fetchedData
    }
    
    func shuffleLibrary() {
        self.mediaLibrary.shuffle()
    }
    
    func sortLibrary(prop: String, reverse: Bool = false ) {
        switch prop {
            case "Title", "name":
                self.mediaLibrary.sort(by:{ ($0.name ?? $0.title) ?? "" < ($1.name ?? $1.title) ?? ""})
            case "Year":
                self.mediaLibrary.sort(by:{ ($0.firstAirDate ?? $0.releaseDate) ?? "" > ($1.firstAirDate ?? $1.releaseDate) ?? ""})
            case "Views":
                self.mediaLibrary.sort(by:{ $0.popularity ?? 0.0 > $1.popularity ?? 0.0 })
            case "Votes":
                self.mediaLibrary.sort(by:{ $0.voteAverage ?? 0.0 > $1.voteAverage ?? 0.0 })
            case "random":
                self.mediaLibrary.shuffle()
            default: break
        }
        if (reverse == true) {
            self.mediaLibrary.reverse()
        }
    }
    
    func fetchAllData() async {
        var fetchedShows: [MediaItem] = []
        var fetchedMovies: [MediaItem] = []
        isRefreshing = true
        defer { isRefreshing = false }
        do {
            fetchedShows = try await client.fetchPopularByType(mediaType: "tv")
        } catch {
            print("Error:", error.localizedDescription)
        }
        do {
            fetchedMovies = try await client.fetchPopularByType(mediaType: "movie")
        } catch {
            print("Error:", error.localizedDescription)
        }
        self.fetchedData = fetchedShows + fetchedMovies
        self.fetchedData.sort(by:{ $0.popularity ?? 0.0 > $1.popularity ?? 0.0 })
        self.updateLibrary()
    }
}

extension String {
    func contains(find: String) -> Bool{
        return self.range(of: find) != nil
    }
    func containsIgnoringCase(find: String) -> Bool{
        return self.range(of: find, options: .caseInsensitive) != nil
    }
}



//struct TestObj: Codable {
//    let aaa: Bool
//    let bbb: Int
//    let ccc: String
//}

//@AppStorage("testKey") private var testData: Data = Data()
//@State var output: String = "Loading..."


//        VStack {
//            Text(output).padding()
//            Button("Load from App Storage") {
//                guard let testObj = try? JSONDecoder().decode(TestObj.self, from: testData) else {return}
//                output = "\(testObj.aaa)...\(testObj.bbb)...\(testObj.ccc)"
//            }.padding()
//            Button("Save to AppStorage") {
//                let testObj = TestObj(aaa: true, bbb: 567, ccc: "abc")
//                guard let testData = try? JSONEncoder().encode(testObj) else {return}
//                self.testData = testData
//            }.padding()
//            Button("FETCH Movies to AppStorage") {
//                Task {
//                    await fetchMedia(mediaType: "movie")
//                    let mediaFetched = mvm.mediaLibrary.count > 0
//                    let text = mediaFetched ? "\(mvm.mediaLibrary[1].id)" : "No Data"
//                    let testObj = TestObj(aaa: mediaFetched, bbb: mvm.mediaLibrary.count, ccc: text)
//                    guard let testData = try? JSONEncoder().encode(testObj) else {return}
//                    self.testData = testData
//                }
//            }.padding()
//            Button("FETCH TVs to AppStorage") {
//                Task {
//                    await fetchMedia(mediaType: "tv")
//                    let mediaFetched = mvm.mediaLibrary.count > 0
//                    let text = mediaFetched ? "\(mvm.mediaLibrary[1].id)" : "No Data"
//                    let testObj = TestObj(aaa: mediaFetched, bbb: mvm.mediaLibrary.count, ccc: text)
//                    guard let testData = try? JSONEncoder().encode(testObj) else {return}
//                    self.testData = testData
//                }
//            }.padding()
//        }
