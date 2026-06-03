//
//  APIConfiguration.swift
//  MandiriMovie
//
//  Created by ITUMAC02 on 03/06/26.
//

import Foundation

enum APIConfiguration {
    static var apiKey: String {
        guard let path = Bundle.main.path(forResource: "Config", ofType: "plist"),
              let plist = NSDictionary(contentsOfFile: path),
              let apiKey = plist["TMDB_API_KEY"] as? String
        else {
            fatalError("TMDB_API_KEY not found")
        }
        
        return apiKey
    }
}
