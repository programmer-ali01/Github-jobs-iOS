//
//  Service.swift
//  Github-jobs
//
//  Created by Alisena Mudaber on 10/29/20.
//

import Foundation

class Service {
    static let shared = Service()
    
    func fetchData(description: String, location: String, completed: @escaping (Result<[Results], ErrorMessages>) -> Void) {
        
        let urlString = "https://jobs.github.com/positions.json?description=\(description.replacingOccurrences(of: " ", with: "+"))&location=\(location.replacingOccurrences(of: " ", with: "+"))"
        
        guard let url = URL(string: urlString) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            // error
            if let _ = error {
                completed(.failure(.invalidData))
                return
            }
            
            // response
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            // data
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let results = try decoder.decode([Results].self, from: data)
                completed(.success(results))
            } catch {
                completed(.failure(.invalidData))
            }
        }
        task.resume()
    }
}
