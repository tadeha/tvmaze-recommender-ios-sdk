import Foundation

public struct TVShowRecommender {
    
    static public var shared = TVShowRecommender()
    
    private init() {}
    
    public enum SearchType {
        /// In this version of nearest neighbors, each TV show feature got a different weight depending on its importance (e.g. genre has the highest weight due to its importance).
        case weighted
        
        /// A simple non-weighted nearest neighbors search model.
        case basic
    }
    
    /// Get Recommeded TV Shows TVMaze Show IDs
    /// - Parameters:
    ///   - showID: Corresponding TV Show ID from TVMaze.
    ///   - numberOfRecs: How many similar shows do you want to find from Show ID?
    ///   - searchType: Switch between different search types which correspond to the type of machine learning model used.
    ///   - completion: returns list of recommended tv shows
    public func getRecommendation(for showID: Int, numberOfRecs: Int = 10, searchType: SearchType = .basic, completion: @escaping ([TVShow]?, Bool) -> Void) {
        if let url = URL(string: "https://tvmaze-flask-model.herokuapp.com/recommend") {
            var request = URLRequest(url: url)
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpMethod = "POST"
            let body: [String: Any] = [
                "show_id": showID,
                "num_of_recs": numberOfRecs,
                "weighted_model" : searchType == .weighted ? true : false
            ]
            request.httpBody = try? JSONSerialization.data(withJSONObject: body)
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data,
                      let response = response as? HTTPURLResponse,
                      error == nil else {
                          print("error", error ?? "Unknown error")
                          completion(nil, false)
                          return
                      }
                
                guard (200 ... 299) ~= response.statusCode else {
                    print("statusCode should be 2xx, but is \(response.statusCode)")
                    print("response = \(response)")
                    completion(nil, false)
                    return
                }
                
                if let decodedResponse = try? JSONDecoder().decode(SimilarShows.self, from: data) {
                    print("response => \(decodedResponse)")
                    completion(decodedResponse.recommendations.sorted(by: {$0.weight < $1.weight}), decodedResponse.trending_shows)
                    return
                } else {
                    completion(nil, false)
                }
            }
            task.resume()
        }
    }
}
