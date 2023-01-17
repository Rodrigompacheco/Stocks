//
//  APIError.swift
//  Stocks
//
//  Created by Rodrigo Pacheco on 16/01/23.
//

import Foundation

enum APIError: Error {
    case custom(String)
}

extension APIError {
    static var makeRequest: APIError {
        return APIError.custom("Couldn't make request.")
    }
    
    static var decode: APIError {
        return APIError.custom("Couldn't decode data.")
    }
    
    static var invalidURL: APIError {
        return APIError.custom("Invalid URL.")
    }
    
    static var invalidData: APIError {
           return APIError.custom("Invalid Data.")
    }
}
