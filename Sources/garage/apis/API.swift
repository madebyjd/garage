//
//  API.swift
//

import Foundation

public enum APIError: Error {
    case badResponse
}

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
