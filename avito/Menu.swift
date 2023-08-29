//
//  Menu.swift
//  avito
//
//  Created by Danil Komarov on 24.08.2023.
//

import Foundation

struct Menu {
    static func allPhotos() -> [Photo] {
        [
            .init(name: "1", imageName: "2"),
            .init(name: "2", imageName: "2"),
            .init(name: "2", imageName: "2"),
            .init(name: "2", imageName: "2"),
            .init(name: "2", imageName: "2"),
            .init(name: "2", imageName: "2"),
        ]
    }
    
    static func randomPhoto(with count: Int) -> [Photo] {
        return (0..<count).map { _ in
            allPhotos().randomElement()!
        }
    }
}

struct Photo{
    var name: String?
    var imageName: String?
}
