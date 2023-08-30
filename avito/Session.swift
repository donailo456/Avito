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
    
    public func convertDateString(_ dateString: String) -> String? {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd"
        
        if let date = inputFormatter.date(from: dateString) {
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = "d MMMM, yyyy"
            let formattedDate = outputFormatter.string(from: date)
            return formattedDate
        }
        
        return nil
    }
}
