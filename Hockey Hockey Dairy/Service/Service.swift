//
//  Service.swift
//  Hockey Hockey Dairy
//
//  Created by Dias Atudinov on 02.07.2024.
//

import Foundation

class ApiService {
    private let baseUrl = "https://codegalaxy.site"
    private let token = "f022af0b-3613-449f-8ef1-7a8bf70ddf32"

    func fetchData(completion: @escaping (Result<ApiResponse, Error>) -> Void) {
        guard let url = URL(string: "\(baseUrl)/app/g4arupp14yb00k") else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            return
        }

        var request = URLRequest(url: url)
        //request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "GET"

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data"])))
                return
            }

            do {
                let decodedData = try JSONDecoder().decode(ApiResponse.self, from: data)
                completion(.success(decodedData))
            } catch {
                completion(.failure(error))
            }
        }

        task.resume()
    }
}
