//
//  QuestionTableViewCell.swift
//  InterviewTest
//
//  Created by Avinash Boora on 2/6/21.
//

import UIKit

class QuestionTableViewCell: UITableViewCell {
    @IBOutlet weak var answersCountLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var tagsLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(question: Item){
        self.answersCountLabel.text = "\(question.answerCount)"
        self.questionLabel.text = "\(question.title)"
        self.tagsLabel.text = "\(question.tags.map{txt in "#\(txt)"}.joined(separator: "  "))"
        let date  : Date = NSDate(timeIntervalSince1970: TimeInterval(question.creationDate)) as Date
        self.timeLabel.text = "\(date.getElapsedInterval())"
        self.nameLabel.text = "\(question.owner.displayName)"
    }
    
    func setAnswerData(answer: AnswerItem){
        self.answersCountLabel.text = "\(answer.score)"
        self.questionLabel.text = "\(answer.answerID)"
        self.tagsLabel.text = "Acceptance rate : \(answer.owner.acceptRate ?? 0) Owner reputation : \(answer.owner.reputation)"
        let date  : Date = NSDate(timeIntervalSince1970: TimeInterval(answer.lastActivityDate)) as Date
        self.timeLabel.text = "\(date.getElapsedInterval())"
        self.nameLabel.text = "\(answer.owner.displayName)"
    }
}
