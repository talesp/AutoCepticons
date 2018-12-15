//
//  Transformers+Resource.swift
//  AutoCepticons
//
//  Created by Tales Pinheiro De Andrade on 11/24/18.
//  Copyright © 2018 Tales Pinheiro De Andrade. All rights reserved.
//

import Foundation

extension Transformer {
    static private let pathURLString = "transformers"
    static private let baseURL = TransformersAPIConfig.baseURL
    static private let resourceBaseURL = TransformersAPIConfig.baseURL.appendingPathComponent(Transformer.pathURLString)

    static func resource() -> Resource<Transformer> {
        let headers: [HTTPHeader] = [.accept("application/json"), .authorization("Bearer \(UserDefaults.allSpark!)")]
        return Resource(url: Transformer.resourceBaseURL, headers: headers)
    }

    static var allSparkResource: Resource<String> {
        return Resource(url: self.baseURL.appendingPathComponent("allspark"), headers: [], decoder: StringDecoder())
    }

    static func get(id: String) -> Resource<Transformer> {
        let url = Transformer.resourceBaseURL.appendingPathComponent(id)
        return Resource(url: url, headers: [])
    }

    func post() -> Resource<Transformer> {
        let headers: [HTTPHeader] = [.contentType("application/json"), .authorization("Bearer \(UserDefaults.allSpark!)")]
        return Resource(url: Transformer.resourceBaseURL, method: .post(self), headers: headers)
    }

    func put() -> Resource<Transformer> {
        let url = Transformer.resourceBaseURL
        return Resource(url: url, method: .put(self), headers: [])
    }

    func delete() -> Resource<TransformersList> {
        guard let id = self.id else { fatalError("impossible to remove this Transformer")}
        let url = Transformer.resourceBaseURL.appendingPathComponent(id)
        return Resource(url: url, method: .delete, headers: [])
    }
}
