//
//  File.swift
//  
//
//  Created by Jonathan Danek on 5/12/23.
//

import Combine

extension Publisher {

    public func throwErrorForNil<T>(_ error: Error) -> AnyPublisher<T, Error> where Output == Optional<T> {
        self
            .tryMap { element -> T in
                if let element = element {
                    return element
                } else {
                    throw error
                }
            }
            .eraseToAnyPublisher()
    }
}
