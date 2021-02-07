//
//  QuestionsNetworkManager.swift
//  InterviewTest
//
//  Created by Avinash Boora on 2/5/21.
//

import Foundation
// MARK: - URLSession response handlers

extension URLSession {
    
    fileprivate func codableTask<T: Codable>(with url: URL, completionHandler: @escaping (T?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return self.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completionHandler(nil, response, error)
                return
            }
            completionHandler(try? QuestionsDecoder().decode(T.self, from: data), response, nil)
        }
        
    }
    
    func QuestionsTask(with url: URL, completionHandler: @escaping (Questions?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return self.codableTask(with: url, completionHandler: completionHandler)
    }


}
