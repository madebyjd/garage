//
//  API.swift
//  
//
//  Created by Jonathan Danek on 5/10/23.
//

import Foundation

public protocol API {

    var urlSesssion: URLSession { get }

    var baseUrl: URL { get }

}
