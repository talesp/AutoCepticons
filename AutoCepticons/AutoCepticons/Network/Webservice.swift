//
//  Webservice.swift
//  AutoCepticons
//
//  Created by Tales Pinheiro De Andrade on 11/24/18.
//  Copyright © 2018 Tales Pinheiro De Andrade. All rights reserved.
//

import Foundation
import os

enum Result<T, E: Error> {
    case success(T)
    case failure(E)

    init(_ value: T) {
        self = Result.success(value)
    }

    init(_ value: E) {
        self = Result.failure(value)
    }

}

enum NetworkError: Error {
    case invalidData
    case emptyData
    case clientError(String)
    case redirection
    case serverError
    case networkError(String)
    case unknowm
}

final class Webservice: NSObject {

    let urlSession: URLSession
    private let log = OSLog(subsystem: "com.talesp.autocepticons", category: "network")
    init(urlSession: URLSession = URLSession(configuration: URLSessionConfiguration.default)) {
        self.urlSession = urlSession
    }

    @discardableResult
    func load<T>(_ resource: Resource<T>,
                 completion: @escaping (Result<T, NetworkError>) -> Void) -> URLSessionDataTask {

        let request = URLRequest(resource: resource)

        let task = urlSession.dataTask(with: request) { [unowned self] data, urlResponse, error in
            let result: Result<T, NetworkError>
            if let response = urlResponse as? HTTPURLResponse, let status = response.status, let data = data {
                switch status.responseType {
                case .success:
                    os_log(OSLogType.debug,
                           log: self.log,
                           "got [%{private}s] from network",
                           String(describing: type(of: data)))
                    result = self.parse(data, for: resource, error: error)
                case .redirection:
                    os_log(OSLogType.debug,
                           log: self.log,
                           "Redirected to somewhere else...")
                        result = Result(.redirection)
                case .clientError:
                    let content = String(decoding: data, as: UTF8.self)
                    let localizedStatusCode = HTTPURLResponse.localizedString(forStatusCode: response.statusCode)
                    let message = "[\(response.statusCode)]: \(localizedStatusCode) -> \(content)"
                    os_log(OSLogType.error, log: self.log, "%{private}s", message)
                    result = Result(NetworkError.clientError(message))
                case .serverError:
                    os_log(OSLogType.error,
                           log: self.log,
                           "Server error: [%{private}s]",
                           error?.localizedDescription ?? "")
                    result = Result(.serverError)
                default:
                    os_log(OSLogType.error,
                           log: self.log,
                           "Unknown error: [%{private}s]",
                           error?.localizedDescription ?? "")
                    result = Result(.unknowm)
                }
            }
            else if let error = error {
                os_log(OSLogType.error, log: self.log, "Unknown error: [%{private}s]", error.localizedDescription)
                result = Result(.networkError(error.localizedDescription))
            }
            else {
                result = Result(.unknowm)
            }
            completion(result)
        }
        task.resume()
        return task
    }

    private func parse<T>(_ data: Data?,
                          for resource: Resource<T>,
                          error: Error?) -> Result<T, NetworkError> where T: Decodable {
        let result: Result<T, NetworkError>
        if let data = data {
            do {
                result = try Result(resource.parse(data))
            }
            catch {
                os_log(OSLogType.error, log: self.log, "error: [%{private}s] parsing data", error.localizedDescription)
                result = Result(NetworkError.invalidData)
            }
        }
        else if let error = error {
            print(error.localizedDescription)
            fatalError("FIXME")
        }
        else {
            result = Result(NetworkError.emptyData)
        }
        return result
    }
}
