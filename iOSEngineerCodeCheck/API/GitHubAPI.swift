//
//  GitHubAPI.swift
//  iOSEngineerCodeCheck
//
//  Created by 大江祥太郎 on 2021/07/07.
//  Copyright © 2021 YUMEMI Inc. All rights reserved.
//

import APIKit

struct DecodableDataParser<T: Decodable>: DataParser {
    let contentType: String? = "application/json"
    
    func parse(data: Data) throws -> Any {
        return try JSONDecoder().decode(T.self, from: data)
    }
}

protocol GitHubRequest: Request { }

extension GitHubRequest {
    var baseURL: URL {
        URL(string: "https://api.github.com")!
    }
}

extension GitHubRequest where Response: Decodable {
    var dataParser: DataParser {
        return DecodableDataParser<Response>()
    }
}

struct GitHubAPI {
    private init () {}
    
    struct SearchRepositories: GitHubRequest {
        typealias Response = SearchResponse

        let method: HTTPMethod = .get
        let path: String = "/search/repositories"
        
        var parameters: Any? {
            return [
                    "q": query,
                    "page": page,
                    "per_page": perPage
                   ]
        }

        let query: String
        let page: Int
        let perPage: Int = 20
        
        func response(from object: Any, urlResponse: HTTPURLResponse) throws -> Response {
            return try (object as? Response) ??
                { throw ResponseError.unexpectedObject(object) }()
        }
    }
    
    static func call<T: GitHubRequest>(request: T, completion: @escaping (Result<T.Response, SessionTaskError>) -> Void) -> SessionTask? {
        return Session.send(request) { (result) in
            completion(result)
        }
    }
}

