//
//  WebService.swift
//  CryptoCrazySwiftUI
//
//  Created by Mustafa Kemal ARDA on 16.11.2023.
//

import Foundation


class WebService {
    
    /*
     func downloadCurrenciesAsync(url: URL) async throws -> [CryptoCurrency]? {
     
     let (data, _) = try await URLSession.shared.data(from: url)
     
     let currencies = try? JSONDecoder().decode([CryptoCurrency].self, from: data)
     
     return currencies ?? []
     
     }
     */
    
    func downloadCurrenciesContinuation(url:URL) async throws -> [CryptoCurrency] {
        
        try await withCheckedThrowingContinuation { continuation in
            
            downloadCurrencies(url: url) { result in
                switch result {
                case .success(let cryptos):
                    continuation.resume(returning: cryptos ?? [])
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
        
    }
    
    
    func downloadCurrencies(url: URL, completion: @escaping (Result<[CryptoCurrency]?,DownloaderError>) -> Void) {
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let error = error {                      // url mesajında hata alırsak göstermemiz gereken hata mesajı
                print(error.localizedDescription)
                completion(.failure(.badUrl))
            }
            
            guard let data = data,  error == nil else {
                return completion(.failure(.noData))        // Data hata mesajı
            }
            
            guard let currencies = try? JSONDecoder().decode([CryptoCurrency].self, from: data) else {
                return completion(.failure(.dataParseError))    // JSON hata mesajı
            }
            
            completion(.success(currencies))        // tamamlandı mesajı
        }
        .resume()
        
        
    }
    
    
    enum DownloaderError : Error {
        case badUrl
        case noData
        case dataParseError
    }
}
