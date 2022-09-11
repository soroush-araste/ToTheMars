//
//  Router.swift
//  ElonMuskDream
//
//  Created by soroush amini araste on 9/11/22.
//

import Foundation

class Router<EndPoint: EndPointType> {

    private var task: URLSessionTask?
    
    func perform(_ route: EndPoint, _ decoder: JSONDecoder = JSONDecoder(), completion: @escaping (Result<EndPoint.Response,NetworkError>) -> Void) {
        let session = URLSession.shared
        do {
            let request = try self.buildRequest(from: route)
            task = session.dataTask(with: request, completionHandler: { [weak self] data, response, error in

                guard let self = self else { return }
                NetworkLogger.log(request: request, data: data, response: response as? HTTPURLResponse)
                if let error = error {
                    completion(.failure(.noInternetConnection(message: error.localizedDescription)))
                }
                
                guard let data = data else {
                    return completion(.failure(.noData))
                }
                
                guard let response = response as? HTTPURLResponse else {
                    return completion(.failure(.badResponse))
                }
                
                self.handleRequestResponse(response,
                                                                data: data,
                                                                decoder: decoder,
                                                                completion: completion)
                
            })
        } catch {
            completion(.failure(.requestBuildFailed))
        }
        self.task?.resume()
    }
    
    // MARK: - Handle status codes and actions -
    fileprivate func handleRequestResponse(_ response: HTTPURLResponse,
                                           data: Data,
                                           decoder: JSONDecoder,
                                           completion: @escaping (Result<EndPoint.Response, NetworkError>) -> Void) {
        
        switch response.statusCode {
        case 200...299:
            do {
                let decodedModel = try decoder.decode(EndPoint.Response.self, from: data)
                completion(.success(decodedModel))
            } catch let error {
                completion(.failure(.unableToDecode(error: error)))
            }
        case 400:
            completion(.failure(.badRequest))
        case 403:
            completion(.failure(.forbidden))
        case 401:
            completion(.failure(.unauthorized))
        case 422:
            completion(.failure(.validation))
        case 404:
            completion(.failure(.notFound))
        case 400...499:
            completion(.failure(.badRequest))
            
        case 500...599:
            completion(.failure(.internalServerError))
            
        default:
            completion(.failure(.unknown))
        }
    }
    
    func cancel() {
        self.task?.cancel()
    }
    
    fileprivate func buildRequest(from route: EndPoint) throws -> URLRequest {
        
        //let marketType = route.marketType.rawValue // setup MarketType For Handled Change Market
            
        var request = URLRequest(url: route.baseURL.appendingPathComponent(route.version + route.path),
                                 cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
                                 timeoutInterval: 10.0)
        
        request.httpMethod = route.HTTPMethod.rawValue
        
        self.addAdditionalHeaders(route.headers, request: &request)
        
        do {
            switch route.task {
            case let .urlRequest(urlParameters):
                try URLParameterEncoder().encode(urlRequest: &request, with: urlParameters)
                
            case let .jsonRequest(requestModel):
                try JSONParameterEncoder().encode(urlRequest: &request, with: requestModel)
                
            case let .jsonAndURLRequest(urlParameters, requestModel):
                try URLParameterEncoder().encode(urlRequest: &request, with: urlParameters)
                try JSONParameterEncoder().encode(urlRequest: &request, with: requestModel)
            }
            return request
        } catch {
            throw error
        }
    }
    
    fileprivate func addAdditionalHeaders(_ additionalHeaders: HTTPHeaders?, request: inout URLRequest) {
        guard let headers = additionalHeaders else { return }
        for (key, value) in headers {
            request.setValue(value, forHTTPHeaderField: key)
        }
    }
}
