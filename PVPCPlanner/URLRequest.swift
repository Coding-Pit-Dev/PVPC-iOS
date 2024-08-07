//
//  URLRequest.swift
//  PVPCPlanner
//
//  Created by Alberto Alegre Bravo on 7/8/24.
//

import Foundation

extension URLRequest {
    static func get(url: URL) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Accept")

        return request
    }
}
