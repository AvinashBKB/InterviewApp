//
//  AnswersViewModel.swift
//  InterviewTest
//
//  Created by Avinash Boora on 2/6/21.
//

import Foundation
class AnswersViewModel{
    var answers : Answers?
    init() {
        //
    }
    
    func getAnswers(qID : Int,completionHandler :  @escaping (_ error : Error?)->()){
        if let url = URL.init(string: Constants.baseURL+"/\(qID)/"+Constants.answersURL){
            NetworkManager().answerAPI(with: url , completionHandler: { (qns, response, error) in
                if error == nil {
                    if let hasAnswers = qns {
                        self.answers = hasAnswers
                    }
                    completionHandler(error)
                }
                else{
                    completionHandler(error)
                }
            })
        }
    }
}

