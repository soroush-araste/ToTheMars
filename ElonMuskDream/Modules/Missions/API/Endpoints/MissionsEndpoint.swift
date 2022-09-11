//
//  MissionsEndpoint.swift
//  ElonMuskDream
//
//  Created by soroush amini araste on 9/6/22.
//

struct MissionService: EndPointType {
    
    static let agent = Router<Self>()
    
    private var requestModel: Request
    
    init(request: Request) {
        self.requestModel = request
    }
    
    var path: String {
        return "/launches/query"
    }
    
    var HTTPMethod: HTTPMethod {
        return .post
    }
    
    var task: HTTPTask<Request> {
        return .jsonRequest(request: requestModel)
    }
    
    var headers: HTTPHeaders? {
        return NetworkConfig.RequestHeader.defaultValues
    }
    
    var version: String {
        return NetworkConfig.APIVersion.v5.rawValue
    }
}

extension MissionService {
    typealias RequestType = Request
    typealias ResponseType = Response
    
    struct Request: Encodable {
        let query: Query = Query()
        let options: Options
    }
    
    struct Response: Decodable {
        let docs: [Doc]
        let totalDocs, limit, totalPages, page: Int
        let pagingCounter: Int
        let hasPrevPage, hasNextPage: Bool
        let prevPage, nextPage: Int?
    }
        
    static func getLaunchesList(request: Request, completion: @escaping (Result<Response, NetworkError>) -> Void) {
        agent.perform(.init(request: request),
                      completion: completion)
    }
}
