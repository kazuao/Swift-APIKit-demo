//
//  RateLimitRequest.swift
//  APIKit-demo
//
//  Created by k-aoki on 2021/08/06.
//

import Foundation
import APIKit

protocol GithubRequestProtocol: Request {
    associatedtype Element
    typealias Response = Element
    
    var baseURL: URL { get }
    var method: HTTPMethod { get }
    var path: String { get }
    var headerField: [String: String] { get }
    var parameters: Any? { get }
    
    func response(from object: Any, urlResponse: HTTPURLResponse) throws -> Element
}

extension GithubRequestProtocol {
    var baseURL: URL {
        return URL(string: "https://api.github.com")!
    }
}

struct RateLimitRequest: GithubRequestProtocol {
    typealias Response = RateLimit
    
    var baseURL: URL {
        return self.baseURL
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var path: String {
        return "/rate_limit"
    }
    
    var headerField: [String : String] {
        return ["x-other": "xxxx", "y-other": "yyyy"]
    }
    
    var parameters: Any? {
        return ["q": query]
    }
    
    func response(from object: Any, urlResponse: HTTPURLResponse) throws -> Response {
        return try RateLimit(object: object)
    }
}

struct RateLimit {
    let limit: Int
    let remaining: Int
    
    init(object: Any) throws {
        guard let dictionary = object as? [String: Any],
              let rateDictionary = dictionary["rate"] as? [String: Any],
              let limit = rateDictionary["limit"] as? Int,
              let remaining = rateDictionary["remaining"] as? Int else {
            throw ResponseError.unexpectedObject(object)
        }
        
        self.limit = limit
        self.remaining = remaining
    }
}
