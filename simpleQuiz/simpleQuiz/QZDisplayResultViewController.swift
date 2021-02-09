//
//  QZDisplayResultViewController.swift
//  simpleQuiz
//
//  Created by Vijay on 09/02/21.
//

import UIKit

class QZDisplayResultViewController: UIViewController {

    @IBOutlet weak var lblWrongAnswer: UILabel!
    @IBOutlet weak var lblCorrectAnswer: UILabel!
    @IBOutlet weak var lblYourScore: UILabel!
    var yourScore: Int = 0
    var noOfCorrectAnswer : Int = 0
    var noOfInCorrectAnswer : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lblYourScore.text = "Your Score Is:\(String(yourScore))"
        lblCorrectAnswer.text = "Your Total Correct Answer: \(String(noOfCorrectAnswer))"
        lblWrongAnswer.text =  "Your Total Incorrect Answer: \(String(noOfInCorrectAnswer))"
        // Do any additional setup after loading the view.
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
