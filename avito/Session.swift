//
//  Session.swift
//  avito
//
//  Created by Danil Komarov on 26.08.2023.
//

import Foundation

class Session {
    static let shared = Session()
    private init() {}
    
    var idSession: String = ""
}
