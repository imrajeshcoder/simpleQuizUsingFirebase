//
//  quizDisplayViewController.swift
//  simpleQuiz
//
//  Created by Vijay on 09/02/21.
//

import UIKit
import SQLite3

let fileURL = try! FileManager.default
    .url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
    .appendingPathComponent("user.sqlite")
var db: OpaquePointer?
internal let SQLITE_STATIC = unsafeBitCast(0, to: sqlite3_destructor_type.self)
internal let SQLITE_TRANSIENT = unsafeBitCast(-1, to: sqlite3_destructor_type.self)
var statement: OpaquePointer?
var lastVisitedQuetion = 0
var NoOfQuetionInTable = 0
var currentQuetion = 0
class quizDisplayViewController: UIViewController {

    
    @IBOutlet weak var lblQetionNo: UILabel!
    
    @IBOutlet weak var lblQuetion: UILabel!
    @IBOutlet weak var btnOption1: UIButton!
    @IBOutlet weak var btnOption2: UIButton!
    @IBOutlet weak var btnOption3: UIButton!
    @IBOutlet weak var btnOption4: UIButton!
       
    var lastQuetionId = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        openDataBase()
        lastVisitedQuetion = getLastLastVIsitedQuetion()
      //  lastQuetionId = getLastQuetionId()
        NoOfQuetionInTable = getNoOfQuetionInTable()
        if lastVisitedQuetion < NoOfQuetionInTable
        {
            singleQuetionDisplay(quetionId: lastVisitedQuetion+1)
        }
        else if lastVisitedQuetion == NoOfQuetionInTable
        {
            displayResult()
//            print("You Attempted All Quetion in Test.")
//            return
        }
    }
    
    func openDataBase()  {
            guard sqlite3_open(fileURL.path, &db) == SQLITE_OK  else {
                print("error opening database")
                sqlite3_close(db)
                db = nil
                return
            }
            print(fileURL.path)
        }
    func getLastLastVIsitedQuetion() -> Int {
            
            if sqlite3_prepare_v2(db, "select MAX(questionid) from questionmaster where isanswergiven = 1 ", -1, &statement, nil) != SQLITE_OK {
                let errmsg = String(cString: sqlite3_errmsg(db)!)
                print("error preparing select: \(errmsg)")
            }
            while(sqlite3_step(statement) == SQLITE_ROW){
                    let max = sqlite3_column_int(statement, 0)
                    print(" Last Quetion IS:\(max)")
                return Int(max)
                }

            return 0
        }
    func getLastQuetionId() -> Int {
        if sqlite3_prepare_v2(db, "select MAX(questionid) from questionmaster", -1, &statement, nil) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error preparing select: \(errmsg)")
        }
        while(sqlite3_step(statement) == SQLITE_ROW){
                let lastQuetionId = sqlite3_column_int(statement, 0)
                print("\(lastQuetionId)")
            return Int(lastQuetionId)
            }

        return 0
    }
    // get no of quetion in table
    func getNoOfQuetionInTable() -> Int
    {
        if sqlite3_prepare_v2(db, "select COUNT(questionid) from questionmaster", -1, &statement, nil) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error preparing select: \(errmsg)")
        }
        while(sqlite3_step(statement) == SQLITE_ROW){
                let NoOfQuetionInTable = sqlite3_column_int(statement, 0)
               // print(" NO OF Q: \(NoOfQuetionInTable)")
            return Int(NoOfQuetionInTable)
            }
        return 0
    }
    func singleQuetionDisplay(quetionId : Int) {
        if sqlite3_prepare_v2(db, "select * from questionmaster where questionid=\(quetionId) ", -1, &statement, nil) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error preparing select: \(errmsg)")
        }

        while sqlite3_step(statement) == SQLITE_ROW {
            let id = sqlite3_column_int64(statement, 0)
            currentQuetion = Int(id)
            //print("id = \(id) ", terminator: "")
            lblQetionNo.text = "Q: \(id)"
            
            if let cString = sqlite3_column_text(statement, 1) {
                let quetion = String(cString: cString)
                lblQuetion.text = quetion
                //print(" Quetion = \(quetion)")
            } else {
                print("quetion not found")
            }

            if let cString = sqlite3_column_text(statement, 2) {
                let  option1 = String(cString: cString)
                //print(" option1 = \(option1)" )
                btnOption1.setTitle(option1, for: .normal)
            } else {
                print("option1 not found")
            }

            if let cString = sqlite3_column_text(statement, 3) {
                let  option2 = String(cString: cString)
                //print(" option2 = \(option2)" )
                btnOption2.setTitle(option2, for: .normal)
            } else {
                print("option2 not found")
            }

            if let cString = sqlite3_column_text(statement, 4) {
                let  option3 = String(cString: cString)
                //print(" option3 = \(option3)" )
                btnOption3.setTitle(option3, for: .normal)
            } else {
                print("option3 not found")
            }

            if let cString = sqlite3_column_text(statement, 5) {
                let  option4 = String(cString: cString)
               // print(" option4 = \(option4)" )
                btnOption4.setTitle(option4, for: .normal)
            } else {
                print("option2 not found")
            }
        }

        if sqlite3_finalize(statement) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error finalizing prepared statement: \(errmsg)")
        }
        statement = nil
    }
    func updateQuetionAnswer(quetionId: Int , selectedAnswer: Int)
    {
        let query = "UPDATE questionmaster SET isanswergiven = '\(1)', userselectanswer = '\(selectedAnswer)' WHERE questionid = \(currentQuetion);"
               if sqlite3_prepare_v2(db, query, -1, &statement, nil) == SQLITE_OK{
                   if sqlite3_step(statement) == SQLITE_DONE {
                       print("Data updated success")
                   }else {
                       print("Data is not updated in table")
                   }
               }
    }
    
    func allRadioUncheked() {
            btnOption1.isSelected = false
            btnOption2.isSelected = false
            btnOption3.isSelected = false
            btnOption4.isSelected = false
        }
    
    func calculateResult() -> Int {
        var result : Int = 0
        if sqlite3_prepare_v2(db, "select COUNT(questionid) from questionmaster WHERE currectanswer = userselectanswer", -1, &statement, nil) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error preparing select: \(errmsg)")
        }
        while(sqlite3_step(statement) == SQLITE_ROW){
                let currectAnswer = sqlite3_column_int(statement, 0)
               // print(" NO OF Q: \(NoOfQuetionInTable)")
            result = Int(currectAnswer)
            return Int(result)
            }
        return result
    }
    func displayResult(){
        if let vc = storyboard?.instantiateViewController(identifier: "QZDisplayResultViewController") as? QZDisplayResultViewController
        {
            var resul = calculateResult()
            vc.yourScore = resul
            vc.noOfCorrectAnswer = resul
            vc.noOfInCorrectAnswer = NoOfQuetionInTable - resul
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    @IBAction func btnActionOptionChange(_ sender: UIButton) {
        allRadioUncheked()
        sender.isSelected = true
        updateQuetionAnswer(quetionId: currentQuetion, selectedAnswer: sender.tag)
    }
    
    @IBAction func btnActionNextClick(_ sender: UIButton) {
        
        lastVisitedQuetion = getLastLastVIsitedQuetion()
        NoOfQuetionInTable = getNoOfQuetionInTable()
        
        if lastVisitedQuetion == NoOfQuetionInTable
        {
            displayResult()
            print("You Attempted All Quetion in Test.")
        }
        else
        {
            allRadioUncheked()
            if lastVisitedQuetion == NoOfQuetionInTable-1
            {
                sender.setTitle("Submit", for: .normal)
            }
            
            if lastVisitedQuetion < NoOfQuetionInTable
            {
                singleQuetionDisplay(quetionId: lastVisitedQuetion+1)
            }
        }
        
    
  
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
