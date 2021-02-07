//
//  AnswersViewController.swift
//  InterviewTest
//
//  Created by Avinash Boora on 2/6/21.
//

import UIKit

class AnswersViewController: UIViewController {
    @IBOutlet weak var answerTableview: UITableView!
    var question : Item? = nil
    let answerViewModel = AnswersViewModel()
    @IBOutlet weak var answersCountLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var tagsLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.getAnswers()
    }
    
    func getAnswers(){
        if let q = question{
            self.setData(question: q)
        }
        DispatchQueue.main.async {
            self.showLoader()
        }
        if let qID = question?.questionID{
            answerViewModel.getAnswers(qID :  qID){ [weak self] error in
                if error == nil{
                    DispatchQueue.main.async {
                        self?.answerTableview.reloadData()
                        self?.hideLoader()
                    }
                }
                else{
                    self?.hideLoader()
                    self?.showAlert(message : error?.localizedDescription ?? "Unknown error")
                }
            }
        }
        else{
            self.showAlert(message : "Question id not found")
        }
    }
    
    func setData(question: Item){
        self.answersCountLabel.text = "\(question.answerCount)"
        self.questionLabel.text = "\(question.title)"
        self.tagsLabel.text = "\(question.tags.map{txt in "#\(txt)"}.joined(separator: "  "))"
        let date  : Date = NSDate(timeIntervalSince1970: TimeInterval(question.creationDate)) as Date
        self.timeLabel.text = "\(date.getElapsedInterval())"
        self.nameLabel.text = "\(question.owner.displayName)"
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension AnswersViewController : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return answerViewModel.answers?.items.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "QuestionTableViewCell") as! QuestionTableViewCell
        if let answer = answerViewModel.answers?.items[indexPath.row]{
            cell.setAnswerData(answer: answer)
        }
        return cell
    }
    
    
}
