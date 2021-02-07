//
//  Util.swift
//  InterviewTest
//
//  Created by Avinash Boora on 2/5/21.
//

import UIKit
import Foundation

extension UIViewController{
    func showAlert(message : String){
        let alert = UIAlertController.init(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction.init(title: "Ok", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func showLoader(){
        DispatchQueue.main.async{ [self] in
            let alert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)
            let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
            loadingIndicator.hidesWhenStopped = true
            loadingIndicator.style = UIActivityIndicatorView.Style.medium
            loadingIndicator.startAnimating()
            alert.view.addSubview(loadingIndicator)
            present(alert, animated: true, completion: nil)
        }
    }
    
    func hideLoader(){
        DispatchQueue.main.async{
            self.dismiss(animated: true, completion: nil)
        }
    }
}
extension Date {
    
    func getElapsedInterval() -> String {
        
        let interval = Calendar.current.dateComponents([.year, .month, .day, .hour,.minute], from: self, to: Date())
        
        if let year = interval.year, year > 0 {
            return year == 1 ? "\(year)" + " " + "year ago" :
                "\(year)" + " " + "years ago"
        } else if let month = interval.month, month > 0 {
            return month == 1 ? "\(month)" + " " + "month ago" :
                "\(month)" + " " + "months ago"
        } else if let day = interval.day, day > 0 {
            return day == 1 ? "\(day)" + " " + "day ago" :
                "\(day)" + " " + "days ago"
        }else if let min = interval.minute, min > 0 {
            return min == 1 ? "\(min)" + " " + "min ago" :
                "\(min)" + " " + "mins ago"
        }else if let hour = interval.hour, hour > 0 {
            return hour == 1 ? "\(hour)" + " " + "hour ago" :
                "\(hour)" + " " + "hours ago"
        } else {
            return "a moment ago"
            
        }
        
    }
}
