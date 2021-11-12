import Foundation

struct SimilarShows: Codable {
    let similarShow: [String: String]
    
    enum CodingKeys: String, CodingKey {
        case similarShow = "similar_show"
    }
}

public struct TVShow: Codable {
    public let id, name: String
}

public struct MovieRecommender {
    
    static public var shared = MovieRecommender()
    
    private init() {}
    
    public enum SearchType {
        case weighted, basic
    }
    
    public func getRecommendation(for showID: Int, numberOfResponse: Int, searchType: SearchType = .basic, completion: @escaping ([TVShow]?) -> Void) {
        if let url = URL(string: "https://tvmaze-flask-model.herokuapp.com/recommend") {
            var request = URLRequest(url: url)
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpMethod = "POST"
            let body: [String: Any] = [
                "show_id": showID,
                "num_of_recs": numberOfResponse,
                "weighted_model" : searchType == .basic ? false : true
            ]
            request.httpBody = try? JSONSerialization.data(withJSONObject: body)
            
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

extension Dictionary {
    func percentEncoded() -> Data? {
        return map { key, value in
            let escapedKey = "\(key)".addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? ""
            let escapedValue = "\(value)".addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? ""
            return escapedKey + "=" + escapedValue
        }
        .joined(separator: "&")
        .data(using: .utf8)
    }
}

extension CharacterSet {
    static let urlQueryValueAllowed: CharacterSet = {
        let generalDelimitersToEncode = ":#[]@" // does not include "?" or "/" due to RFC 3986 - Section 3.4
        let subDelimitersToEncode = "!$&'()*+,;="

        var allowed = CharacterSet.urlQueryAllowed
        allowed.remove(charactersIn: "\(generalDelimitersToEncode)\(subDelimitersToEncode)")
        return allowed
    }()
}
