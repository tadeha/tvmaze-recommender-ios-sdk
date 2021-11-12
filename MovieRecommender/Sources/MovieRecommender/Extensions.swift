//
//  File.swift
//  
//
//  Created by Alireza on 11/12/21.
//

import Foundation

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

extension JSONDecoder {
  func decodeModel<T : Decodable>(type:T.Type, str:String?) -> T? {
    
    if str == nil {
      return nil
    }
    
    do {
      return try JSONDecoder().decode(type, from: str!.data(using: .utf8)!)
    } catch {
        print("Decode JSON Catch: \(type) \(error)")
    }
    return nil
  }
}
