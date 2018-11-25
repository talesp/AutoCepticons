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
        return Resource(url: Transformer.resourceBaseURL)
    }

    static func get(id: String) -> Resource<Transformer> {
        let url = Transformer.resourceBaseURL.appendingPathComponent(id)
        return Resource(url: url)
    }

    func put() -> Resource<Transformer> {
        let url = Transformer.resourceBaseURL
        return Resource(url: url, method: .put(self))
    }

    func delete() -> Resource<TransformersList> {
        guard let id = self.id else { fatalError("impossible to remove this Transformer")}
        let url = Transformer.resourceBaseURL.appendingPathComponent(id)
        return Resource(url: url, method: .delete)
    }
}
