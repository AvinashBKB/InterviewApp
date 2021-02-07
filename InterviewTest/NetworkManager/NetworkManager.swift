//
//  NetworkManager.swift
//  InterviewTest
//
//  Created by Avinash Boora on 2/6/21.
//

import Foundation
class NetworkManager {
    private let session: URLSession

    // By using a default argument (in this case .shared) we can add dependency
    // injection without making our app code more complicated.
    init(session: URLSession = .shared) {
        self.session = session
    }
    
     func answerAPI(with url: URL, completionHandler: @escaping (Answers?, URLResponse?, Error?) -> Void){
        #if OFFLINE
        if let path = Bundle.main.path(forResource: "answers", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                completionHandler(try? AnswerJSONDecoder().decode(Answers.self, from: data), nil, nil)
            } catch {
                completionHandler(nil, nil, error)
            }
        }
        else{
            print("File not found")
        }
        #else
        let task  = session.AnswersTask(with: url , completionHandler: { (ans, response, error) in
            completionHandler(ans,response,error)
        })
        task.resume()
        #endif
    }
    
     func qeustionAPI(with url: URL, completionHandler: @escaping (Questions?, URLResponse?, Error?) -> Void){
        #if OFFLINE
        if let path = Bundle.main.path(forResource: "questions", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                completionHandler(try? QuestionsDecoder().decode(Questions.self, from: data), nil, nil)
            } catch {
                completionHandler(nil, nil, error)
            }
        }
        else{
            print("File not found")
        }
        #else
        let task  = session.QuestionsTask(with: url , completionHandler: { (qns, response, error) in
            completionHandler(qns,response,error)
        })
        task.resume()
        #endif
    }
}

class URLSessionDataTaskMock: URLSessionDataTask {
    private let closure: () -> Void

    init(closure: @escaping () -> Void) {
        self.closure = closure
    }
    override func resume() {
        closure()
    }
}

class URLSessionMock: URLSession {
    typealias CompletionHandler = (Data?, URLResponse?, Error?) -> Void
    var data: Data?
    var error: Error?
    
    override init() {
        
    }

    override func dataTask(
        with url: URL,
        completionHandler: @escaping CompletionHandler
    ) -> URLSessionDataTask {
        let data = self.data
        let error = self.error

        return URLSessionDataTaskMock {
            completionHandler(data, nil, error)
        }
    }
}
