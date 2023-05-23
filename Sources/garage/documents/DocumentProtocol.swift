//
//  DocumentProtocol.swift
//

import Foundation

public protocol DocumentProtocol: Identifiable, Storable {

    var createdOn: Date { get }

}
