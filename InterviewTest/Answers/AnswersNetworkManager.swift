//
//  AnswersNetworkManager.swift
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
            completionHandler(try? AnswerJSONDecoder().decode(T.self, from: data), response, nil)
        }
    }

    func AnswersTask(with url: URL, completionHandler: @escaping (Answers?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return self.codableTask(with: url, completionHandler: completionHandler)
    }
    
   
}
