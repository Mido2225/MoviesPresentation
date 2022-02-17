//
//  ApiRouter.swift
//  WawProvider
//
//  Created by Mohamed Aglan on 10/3/21.
//

import Foundation
import Alamofire
import AVFoundation

//let apikey = ""

enum APIRouter {
    case upComingMovies(apiKey:String)
    
    case movieDetails(movieId:String,apiKey:String)
    
    case search(apiKey:String,query:String)
    
}

extension APIRouter {
    // MARK: - HTTPMethod
    private var method: HTTPMethod {
        switch self {
        default:
            return .get
        }
    }
    
    // MARK: - Path
    private var path: String {
        switch self {
        case .upComingMovies:
            return "3/movie/upcoming"
            
        case .movieDetails(let id, _):
            return "3/movie/\(id)"
            
        case .search:
            return "3/search/movie"

        }
    }
    
    // MARK: - Parameters
    private var parameters: Parameters? {
        switch self {
        case .upComingMovies(let key):
            return [APIParameterKey.apiKey.rawValue:key]
            
        case .movieDetails(_, let key):
            return [APIParameterKey.apiKey.rawValue:key]

        case .search(let key, let query):
            return [
                APIParameterKey.apiKey.rawValue:key,
                APIParameterKey.query.rawValue:query
            ]
        }
    }
}

// MARK: - URLRequestConvertible
extension APIRouter: URLRequestConvertible {
    func asURLRequest() throws -> URLRequest {
        
        let url = try ServerKeys.baseURL.rawValue.asURL()
//        let lang = Language.isArabic() ? "ar" : "en"
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        
        //MARK: -  HTTTP Method
        urlRequest.httpMethod = method.rawValue
        //MARK: -  Common Headers
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.acceptType.rawValue)
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
//        urlRequest.setValue(lang, forHTTPHeaderField: HTTPHeaderField.lang.rawValue)
        //MARK: -  Token
        if  let token = UserDefaults.accessToken , !token.isEmpty {
            urlRequest.setValue( ContentType.tokenBearer.rawValue + token, forHTTPHeaderField: HTTPHeaderField.authentication.rawValue)
        }
        //MARK: -  Parameters
        if let parameters = parameters {
            if method == .get {
                let queryParams = parameters.map { pair  in
                    return URLQueryItem(name: pair.key, value: "\(pair.value)")
                }
                var components = URLComponents(string:url.appendingPathComponent(path).absoluteString)
                components?.queryItems = queryParams
                urlRequest.url = components?.url
            } else {
                do {
                    urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
                } catch {
                    throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
                }
            }
           
        }
        
        print("\n\n====================================\n🚀🚀FULL REQUEST COMPONENETS::: \n URL:: \(String(describing: (urlRequest.url))) \n Method:: \(String(describing: urlRequest.httpMethod)) \n Header:: \(String(describing: urlRequest.allHTTPHeaderFields))  \n Parameters:: \(String(describing: parameters))\n====================================\n\n" )
        
        return urlRequest
    }
}

extension APIRouter {
    enum errors: String {
        case connectionError = "Connection Error"
        case canNotDecodeData = "Can Not Decode Data"
    }
}



extension APIRouter {
    
    func send<T:Codable> (data: [UploadData]? = nil, completion: @escaping (_ respons: T?, _ errorType: APIRouter.errors?) -> Void) {
        if let data = data {
            self.uploadToServerWith(data: data, completion: completion)
            return
        }
        AF.request(self).responseJSON { data in
            printApiResponse(data.data)
            self.handleResponse(data, completion: completion)
        }
        
    }
    
    private func uploadToServerWith<T: Codable> (data: [UploadData], completion: @escaping (_ respons: T?, _ errorType: APIRouter.errors?) -> Void) {
        AF.upload(multipartFormData: { multipartFormData in
            if let parameters = self.parameters {
                for (key, value) in parameters {
                    multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
                }
            }
            for item in data {
                multipartFormData.append(item.data, withName: item.name, fileName: item.fileName, mimeType: item.mimeType)
            }
            
        }, with: self).uploadProgress(closure: { (progress) in
            print("the Progress is \(progress)")
        }).responseJSON { data in
            printApiResponse(data.data)
            self.handleResponse(data, completion: completion)
        }
    }
    private func handleResponse<T: Codable>(_ response: AFDataResponse<Any>, completion: @escaping (_ respons: T?, _ errorType: APIRouter.errors?) -> Void) {
        switch response.result {
        case .failure(_):
            completion(nil, .connectionError)
        case .success(let value):
            do {
                let decoder = JSONDecoder()
                let jsonData = try? JSONSerialization.data(withJSONObject:value)
                let valueObject  = try decoder.decode(T.self, from: jsonData!)
                completion(valueObject  ,nil)
            } catch {
                completion(nil, .canNotDecodeData)
            }
        }
    }
    
}
