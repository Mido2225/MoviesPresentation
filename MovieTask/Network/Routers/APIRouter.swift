//
//  APIRouter.swift
//  Taskon
//
//  Created by MGAboarab on 02/02/2022.
//

import Alamofire

protocol APIRouter: URLRequestConvertible {
    var method: HTTPMethod {get}
    var path: String {get}
    var parameters: Parameters? {get}
    func send<T:Codable> (data: [UploadData]?, completion: @escaping (_ respons: T) -> Void)
}

extension APIRouter {
    func asURLRequest() throws -> URLRequest {
        
        let url = try ServerKeys.baseURL.rawValue.asURL()
        let lang = Language.isArabic() ? Language.Languages.ar : Language.Languages.en
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        
        // HTTTP Method
        urlRequest.httpMethod = method.rawValue
        // Common Headers
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.acceptType.rawValue)
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
        urlRequest.setValue(lang, forHTTPHeaderField: HTTPHeaderField.lang.rawValue)
        // Token
        if  let token = UserDefaults.accessToken , !token.isEmpty {
            urlRequest.setValue( ContentType.tokenBearer.rawValue + token, forHTTPHeaderField: HTTPHeaderField.authentication.rawValue)
        }else{
            urlRequest.setValue(String(), forHTTPHeaderField: HTTPHeaderField.authentication.rawValue)
        }
        // Parameters
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
    func send<T:Codable> (data: [UploadData]? = nil, completion: @escaping (_ respons: T) -> Void) {
        
        if let data = data {
            self.uploadToServerWith(data: data) { (respons: T?,errorType) in
                if let respons = respons {
                    completion(respons)
                } else if let errorType = errorType {
                    MGAIndicator.dismiss()
                    switch errorType {
                    case .connectionError:
                        AppAlert.showInternetConnectionErrorAlert {
                            MGAIndicator.show(isGif: true)
                            self.send(data: data, completion: completion)
                        }
                    case .canNotDecodeData:
                        AppAlert.showSomethingError()
                    }
                } else {
                    MGAIndicator.dismiss()
                }
            }
            return
        }
        AF.request(self).responseJSON { data in
            printApiResponse(data.data)
            self.handleResponse(data) { (respons: T?,errorType) in
                if let respons = respons {
                    completion(respons)
                } else if let errorType = errorType {
                    MGAIndicator.dismiss()
                    switch errorType {
                    case .connectionError:
                        AppAlert.showInternetConnectionErrorAlert {
                            MGAIndicator.show(isGif: true)
                            self.send(data: nil, completion: completion)
                        }
                    case .canNotDecodeData:
                        AppAlert.showSomethingError()
                    }
                } else {
                    MGAIndicator.dismiss()
                }
            }
        }
        
    }
    
    private func uploadToServerWith<T: Codable> (data: [UploadData], completion: @escaping (_ respons: T?, _ errorType: APIErrors?) -> Void) {
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
    private func handleResponse<T: Codable>(_ response: AFDataResponse<Any>, completion: @escaping (_ respons: T?, _ errorType: APIErrors?) -> Void) {
        switch response.result {
        case .failure(_):
            completion(nil, .connectionError)
        case .success(let value):
            do {
                let decoder = JSONDecoder()
                let jsonData = try? JSONSerialization.data(withJSONObject:value)
                let valueObject  = try decoder.decode(T.self, from: jsonData!)
                
                if let value = valueObject as? APIGloabelResponse {
                    switch value.key {
                    case ResponseKeys.success.rawValue:
                        completion(valueObject ,nil)
                    case ResponseKeys.fail.rawValue:
                        completion(nil ,nil)
                        AppAlert.showErrorAlert(error: value.message)
                    case ResponseKeys.needAdminActivation.rawValue:
                        completion(valueObject ,nil)
                    case ResponseKeys.needActive.rawValue:
                        completion(valueObject ,nil)
                    case ResponseKeys.waitingApprove.rawValue:
                        completion(valueObject ,nil)
                    default:
                        completion(nil ,nil)
                        return
                    }
                }
            } catch DecodingError.keyNotFound(let key, let context) {
                Swift.print("could not find key \(key) in JSON: \(context.debugDescription)")
                completion(nil, .canNotDecodeData)
            } catch DecodingError.valueNotFound(let type, let context) {
                Swift.print("could not find type \(type) in JSON: \(context.debugDescription)")
                completion(nil, .canNotDecodeData)
            } catch DecodingError.typeMismatch(let type, let context) {
                Swift.print("type mismatch for type \(type) in JSON: \(context.debugDescription)")
                completion(nil, .canNotDecodeData)
            } catch DecodingError.dataCorrupted(let context) {
                Swift.print("data found to be corrupted in JSON: \(context.debugDescription)")
                completion(nil, .canNotDecodeData)
            } catch let error as NSError {
                NSLog("Error in read(from:ofType:) domain= \(error.domain), description= \(error.localizedDescription)")
                completion(nil, .canNotDecodeData)
            }
        }
    }
    
}

