//
//  ViewController.swift
//  InterviewTest
//
//  Created by Avinash Boora on 2/5/21.
//

import UIKit

class QuestionsViewController: UIViewController {
    let questionsViewModel = QuestionsViewModel()
    @IBOutlet weak var questionsTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.loadQuestions()
    }
    
    func loadQuestions(){
        self.showLoader()
        questionsViewModel.getQuestions{ [weak self] error in
            self?.hideLoader()
            if error == nil{
                DispatchQueue.main.async {
                    self?.questionsTableView.reloadData()
                }
            }
            else{
                self?.showAlert(message : error?.localizedDescription ?? "Unknown error")
            }
        }
    }
}

extension QuestionsViewController : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questionsViewModel.questions?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:    "QuestionTableViewCell") as! QuestionTableViewCell
        if let q = questionsViewModel.questions?[indexPath.row]{
            cell.setData(question: q)
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let q = questionsViewModel.questions?[indexPath.row]{
            self.performSegue(withIdentifier: "showAnswer", sender: q)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let q = sender as? Item, let view  = segue.destination as? AnswersViewController{
            view.question = q
        }
    }
}

