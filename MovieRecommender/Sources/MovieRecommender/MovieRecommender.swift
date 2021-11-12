import Foundation

struct SimilarShows: Codable {
    let similarShow: [String: String]
    
    enum CodingKeys: String, CodingKey {
        case similarShow = "similar_show"
    }
}

struct TVShow: Codable {
    let id, name: String
}

public class MovieRecommender {
    
    static var shared = MovieRecommender()
    
    private init() {}
    
    func getRecommendation(for showID: Int, numberOfResonse: Int, completion: @escaping ([TVShow]?) -> Void) {
        if let url = URL(string: "https://tvmaze-flask-model.herokuapp.com/recommend") {
            var request = URLRequest(url: url)
            request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            request.httpMethod = "POST"
            let parameters: [String: Any] = [
                "show_id": showID,
                "num_of_recs": numberOfResonse
            ]
            request.httpBody = parameters.percentEncoded()
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data,
                      let response = response as? HTTPURLResponse,
                      error == nil else {
                          print("error", error ?? "Unknown error")
                          completion(nil)
                          return
                      }
                
                guard (200 ... 299) ~= response.statusCode else {
                    print("statusCode should be 2xx, but is \(response.statusCode)")
                    print("response = \(response)")
                    completion(nil)
                    return
                }
                
                if let decodedResponse = try? JSONDecoder().decode(SimilarShows.self, from: data) {
                    let shows = decodedResponse.similarShow.compactMap { (key, value) in
                        return TVShow(id: key, name: value)
                    }
                    completion(shows)
                    return
                } else {
                    completion(nil)
                }
            }
            task.resume()
        }
    }
}
