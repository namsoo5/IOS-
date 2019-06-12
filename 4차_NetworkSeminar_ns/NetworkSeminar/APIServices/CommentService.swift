//
//  CommentService.swift
//  NetworkSeminar
//
//  Created by wookeon on 28/05/2019.
//  Copyright © 2019 wookeon. All rights reserved.
//

import Foundation
import Alamofire

struct CommentService {
    
    static let shared = CommentService()
    let headers: HTTPHeaders = [
        "Content-Type" : "application/json",
        "token" : UserDefaults.standard.string(forKey: "token") ?? ""
    ]
    
    func writeComment(epIdx: Int, content: String, cmtImg: UIImage, completion: @escaping (NetworkResult<Any>) -> Void) {
        
        Alamofire.upload(
            multipartFormData: { (multipart) in
            multipart.append("\(epIdx)".data(using: .utf8)!, withName: "epIdx")
            multipart.append(content.data(using: .utf8)!, withName: "content")
            multipart.append(cmtImg.jpegData(compressionQuality: 0.5)!, withName: "cmtImg", fileName: "image.jpeg", mimeType: "image/jpeg")
            },
            to: APIConstants.CommentURL,
            method: .post,
            headers: headers) { encodingResult in
                switch encodingResult {
                case .success(let upload, _, _):
                    
                    upload.responseData { (response) in
                        if let value = response.result.value {
                            if let status = response.response?.statusCode {
                                
                                switch status {
                                case 200:
                                    do {
                                        let decoder = JSONDecoder()
                                        let result = try decoder.decode(DefaultRes.self, from: value)
                                        
                                        switch result.success {
                                        case true:
                                            completion(.success(result.message))
                                        case false:
                                            completion(.requestErr(result.message))
                                        }
                                    } catch {
                                        print("error")
                                    }
                                case 400:
                                    completion(.pathErr)
                                case 500:
                                    completion(.serverErr)
                                default:
                                    break
                                }
                            }
                        }
                    }
                    break
                case .failure(let err):
                    print(err.localizedDescription)
                    completion(.networkFail)
                    break
                }
                
        }
    }
}
