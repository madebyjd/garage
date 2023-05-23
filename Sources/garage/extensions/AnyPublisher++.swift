//
//  File.swift
//

import Combine

extension Publisher {

    public func throwErrorForNil<T>(_ error: Error) -> AnyPublisher<T, Error> where Output == T? {
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
