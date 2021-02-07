import Foundation

class QuestionsViewModel{
    var questions : [Item]?
    
    init() {
        //
    }
    
    func getQuestions(completionHandler :  @escaping (_ error : Error?)->()){
        if let url = URL.init(string: Constants.baseURL+Constants.questionURL){
            NetworkManager().qeustionAPI(with: url , completionHandler: {[weak self] (qns, response, error) in
                if error == nil {
                    if let hasQuestions = qns {
                        self?.questions = hasQuestions.items.filter{$0.isAnswered && $0.answerCount > 0}
                        completionHandler(error)
                    }
                }
                else{
                    completionHandler(error)
                }
            })
        }
    }
}

