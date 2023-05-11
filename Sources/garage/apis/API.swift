//
//  API.swift
//  
//
//  Created by Jonathan Danek on 5/10/23.
//

import Foundation

public enum APIMethod: String {
    case get = "GET"
}

public protocol API {


    var urlSesssion: URLSession { get }

    var baseUrl: URL { get }

}

extension API {

    public func request(method: APIMethod, url: URL, path: String) -> URLRequest {
        let url = baseUrl.appending(path: path)
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        return request
    }
}
