//
//  NetworkService.swift
//  avito
//
//  Created by Danil Komarov on 25.08.2023.
//

import Foundation

final class NetworkService {
    static let shared = NetworkService()
    struct Constant{
        static let topHeadlinesURL = URL(string: "https://www.avito.st/s/interns-ios/main-page.json")
    }
    
    public func getItemNetwork(complition: @escaping (Result<[Advertisement], Error>) -> Void){
        guard let url = Constant.topHeadlinesURL else {
            return
        }
        let request  = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { (data, _ , error) in
            if let error = error {
                complition(.failure(error))
            }
            else if let data = data {
                do {
                    let result = try JSONDecoder().decode(Response.self, from: data)
                    print("Advertisement: \(result.advertisements.count)")
                    complition(.success(result.advertisements))
                } catch {
                    complition(.failure(error))
                }
            }
        }
        task.resume()
    }
    
    public func getItemDetailNetwork(id: String, complition: @escaping (Result<DetailModel, Error>) -> Void) {
        guard let url = URL(string: "https://www.avito.st/s/interns-ios/details/\(id).json") else {
            return
        }
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { (data, _, error ) in
            if let error = error {
                complition(.failure(error))
            }
            else if let data = data {
                do {
                    let result = try JSONDecoder().decode(DetailModel.self, from: data)
                    print("DetailModel: \(result)")
                    complition(.success(result))
                }
                catch {
                    complition(.failure(error))
                }
            }
        }
        task.resume()
    }
}


