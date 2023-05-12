//
//  DocumentProtocol.swift
//  
//
//  Created by Jonathan Danek on 5/12/23.
//

import Foundation

public protocol DocumentProtocol: Identifiable, Storable {

    var createdOn: Date { get }
    
}
