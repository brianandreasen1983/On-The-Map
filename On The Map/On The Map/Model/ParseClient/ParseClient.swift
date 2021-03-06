//
//  ParseClient.swift
//  On The Map
//
//  Created by Brian Andreasen on 5/26/20.
//  Copyright © 2020 Brian Andreasen. All rights reserved.
//

import Foundation

class ParseClient {
    enum Endpoints {
        static let base = "https://onthemap-api.udacity.com/"
        
        case getStudentInformation
        case postStudentInformation
        
        var stringValue: String {
            switch self {
                case .getStudentInformation: return Endpoints.base + "v1/StudentLocation?limit=100&order=updatedAt"
                case .postStudentInformation: return Endpoints.base + "v1/StudentLocation"
            }
        }
        
        var url: URL{
            return URL(string: stringValue)!
        }
    }
    
    // MARK -- Helper function that performs get requests and can be wrapped in other operations.
    class func taskForGETRequest<ResponseType: Decodable> (url: URL, responseType: ResponseType.Type, completion: @escaping (ResponseType?, Error?) -> Void) -> URLSessionDataTask {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
                return
            }
            let decoder = JSONDecoder()
            
            do {
                let responseObject = try decoder.decode(ResponseType.self, from: data)
                DispatchQueue.main.async {
                    completion(responseObject, nil)
                }
            } catch {
                do {
                    let errorResponse = try decoder.decode(ParseAPIError.self, from: data) as Error
                    DispatchQueue.main.async {
                        completion(nil, errorResponse)
                    }
                } catch {
                    DispatchQueue.main.async {
                        completion(nil, error)
                    }
                }
            }
        }
        
        task.resume()
        return task
    }
    
    // MARK -- Helper function can be embedded in a small wrapper that allows us to perform a POST request.
    class func taskForPOSTRequest<RequestType: Encodable, ResponseType: Decodable>(url: URL, responseType: ResponseType.Type, body: RequestType, completion: @escaping (ResponseType?, Error?) -> Void) {
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = try! JSONEncoder().encode(body)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
                return
            }

            let decoder = JSONDecoder()
            
            do {
                let responseObject = try decoder.decode(ResponseType.self, from: data)
                DispatchQueue.main.async {
                    completion(responseObject, nil)
                }
            } catch {
                do {
                    let errorResponse = try decoder.decode(ParseAPIError.self, from: data) as Error
                    DispatchQueue.main.async {
                        completion(nil, errorResponse)
                    }
                } catch {
                    DispatchQueue.main.async {
                        completion(nil, error)
                    }
                }
            }
        }
        
        task.resume()
    }
        
    // MARK -- Methods used for client facing CRUD operations
    class func getStudentLocationInformation(completion: @escaping ([StudentInformation], Error?) -> Void) {
        taskForGETRequest(url: Endpoints.getStudentInformation.url, responseType: StudentInformationResults.self) { response, error in
            if let response = response {
                completion(response.results, nil)
            } else {
                completion([], error)
            }
        }
    }
    
    class func createStudentInformation(latitude: Double, longitude: Double, mapString: String, linkText: String, completion: @escaping(Bool, Error?) -> Void) {
        let body = PostStudentInformation(uniqueKey: "1234", firstName: "Abe", lastName: "Johnston", mapString: mapString, latitude: latitude, longitude: longitude, mediaURL: linkText)
        
        // MARK -- May need to change the response type to a StudentInformationResponse ??
        taskForPOSTRequest(url: Endpoints.postStudentInformation.url, responseType: PostLocationResponse.self, body: body) { response, error in
            if response != nil {
                completion(true, nil)
            } else {
                // May want to consider passing the error in a completion handler response.
                completion(false, nil)
            }
        }
    }
}
