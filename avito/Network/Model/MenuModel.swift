//
//  MenuModel.swift
//  avito
//
//  Created by Danil Komarov on 26.08.2023.
//

import Foundation

// MARK: - Response
struct Response: Codable {
    let advertisements: [Advertisement]
}

// MARK: - Advertisement
struct Advertisement: Codable {
    let id, title, price, location: String
    let imageURL: String
    let createdDate: String

    enum CodingKeys: String, CodingKey {
        case id, title, price, location
        case imageURL = "image_url"
        case createdDate = "created_date"
    }
}
