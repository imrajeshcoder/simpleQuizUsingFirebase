//
//  ViewController.swift
//  simpleQuiz
//
//  Created by Vijay on 09/02/21.
//

import UIKit
import SQLite3
//
//let fileURL = try! FileManager.default
//    .url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
//    .appendingPathComponent("user.sqlite")
//var db: OpaquePointer?
//internal let SQLITE_STATIC = unsafeBitCast(0, to: sqlite3_destructor_type.self)
//internal let SQLITE_TRANSIENT = unsafeBitCast(-1, to: sqlite3_destructor_type.self)
//var statement: OpaquePointer?
//
//
//
//
//class ViewController: UIViewController {
//
//    @IBOutlet weak var btnnext: UIButton!
//    
//    @IBOutlet weak var lblQuetion: UILabel!
//    @IBOutlet weak var lblQuetionNo: UILabel!
//    
//    @IBOutlet weak var btnOption2: UIButton!
//    @IBOutlet weak var btnOption1: UIButton!
//    @IBOutlet weak var btnOption3: UIButton!
//    @IBOutlet weak var btnOption4: UIButton!
//    
//    
//    var arrayQuetionId = [Int]()
//   // var arrayQuetion = [String]()
//    var arrayoption1 = [String]()
//    var arrayoption2 = [String]()
//    var arrayoption3 = [String]()
//    var arrayoption4 = [String]()
//    var arrayCurrectAnswer = [Int]()
//    var arrayUserSelectedAnswer = [Int]()
//    var currentQuetion = 1
//    var userCurrectAnswer = 0
//    var tmpselectedAnswer = 0
//    
//    var arrayQuetion = [" Name of the first Atomic Submarine of India?  "," Name of the first university of India?", "Where is India's First nuclear centre?", "Where was the first Post Office opened in India?", "Name of the first Indian President to Die in office?"]
//    var dicQuetionOption = [0 : ["option1" : "I.N.S Chakra", "option2": "R.N. Shukla", "option3": "V.R. Gill", "option4":"D.B. Mahawar"],
//                            1 : ["option1" : "Nalanda University", "option2": "Taxshila University", "option3": "Jawahar University", "option4":"Dronacharya University"],
//                            2 : ["option1" : "Tarapur", "option2": "Jaipur", "option3": "Kanpur", "option4":"Raipur"],
//                            3 : ["option1" : "Asaam in 1827", "option2": "Madras in 1928", "option3": "Delhi in 1230", "option4":"Kolkata in 1727"],
//                            4 : ["option1" : "Pranav Mukharji", "option2": "Gyan Jail Singh", "option3": "Dr. Zakir Hussain", "option4":"Rajendra Prasad"]
//                        ]
//    var arrayCorrectAnswer = [1,1,1,4,3]
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        // Do any additional setup after loading the view.
//        lblQuetion.text = "ddfh jkdhf kdhjkdh dk fsdh fhfhgkfhk fdkgf hfk"
//        //lblQuetion.sizeToFit()
////        print("dicQuetionOption:\(dicQuetionOption)")
////        print("Option1:\(dicQuetionOption[0]!["option1"]!)")
////
//        openDataBase()
////        createTable()
////        insertData()
////        selectData()
//   //     quetionDataInitilize()
//   //     quetionDisplay(currentQuetion: currentQuetion)
//    }
//    
//    @IBAction func QuetionOptionSelect(_ sender: UIButton) {
//        allRadioUncheked()
//        sender.isSelected = true
//        tmpselectedAnswer = sender.tag
//        
//    }
//
//    func quetionDisplay(currentQuetion: Int = 1) {
//        lblQuetionNo.text = "Q:\(currentQuetion)"
//        lblQuetion.text = arrayQuetion[currentQuetion-1]
//        btnOption1.setTitle("\(arrayoption1[currentQuetion-1])", for: .normal)
//        btnOption2.setTitle("\(arrayoption2[currentQuetion-1])", for: .normal)
//        btnOption3.setTitle("\(arrayoption3[currentQuetion-1])", for: .normal)
//        btnOption4.setTitle("\(arrayoption4[currentQuetion-1])", for: .normal)
//    }
//    func allRadioUncheked() {
//        btnOption1.isSelected = false
//        btnOption2.isSelected = false
//        btnOption3.isSelected = false
//        btnOption4.isSelected = false
//    }
//    
//    
//    @IBAction func btnNextClick(_ sender: UIButton) {
//        if arrayCurrectAnswer[currentQuetion-1] == tmpselectedAnswer
//        {
//            userCurrectAnswer += 1
//        }
//        
//        if btnnext.title(for: .normal) == "Submit"
//        {
//            print("Your Total Currect Answer Is: \(userCurrectAnswer)")
//        }
//     
//        if (currentQuetion < arrayQuetion.count)
//        {
//            currentQuetion += 1
//            quetionDisplay(currentQuetion: currentQuetion)
//        }
//        
//        if currentQuetion == arrayQuetion.count
//        {
//            //btnnext.isEnabled = false
//            btnnext.setTitle("Submit", for: .normal)
//        }
//        allRadioUncheked()
//    }
//    
//    func openDataBase()  {
//        guard sqlite3_open(fileURL.path, &db) == SQLITE_OK  else {
//            print("error opening database")
//            sqlite3_close(db)
//            db = nil
//            return
//        }
//        print(fileURL.path)
//    }
//    
//    func createTable() {
//        
//                            if sqlite3_exec(db, "create table if not exists questionmaster (questionid integer primary key autoincrement, question text , option1 text , option2 text ,  option3 text ,  option4 text , currectanswer integer , isanswergiven integer , userselectanswer integer)", nil, nil, nil) != SQLITE_OK {
//                                let errmsg = String(cString: sqlite3_errmsg(db)!)
//                                print("error creating table: \(errmsg)")
//                            }
//                            else{print("Successfuly TABLE CREATE...") }
//                        }
//
//    func insertData() {
//
//                        for item in 0...arrayQuetion.count-1
//                        {
//                            var column = 1
//                            if sqlite3_prepare_v2(db, "insert into questionmaster (question,option1,option2,option3,option4,currectanswer,isanswergiven) values (?,?,?,?,?,?,?)", -1, &statement, nil) != SQLITE_OK {
//                                let errmsg = String(cString: sqlite3_errmsg(db)!)
//                                print("error preparing insert: \(errmsg)")
//                            }
//
//                            print("QQ:\(arrayQuetion[item])")
//                            if sqlite3_bind_text(statement, Int32(column), "\(arrayQuetion[item])", -1, SQLITE_TRANSIENT) != SQLITE_OK {
//                                let errmsg = String(cString: sqlite3_errmsg(db)!)
//                                print("failure binding foo: \(errmsg)")
//                            }
//                            column += 1
//                            for i in 1...dicQuetionOption[item]!.count {
//                                if sqlite3_bind_text(statement, Int32(column), "\(dicQuetionOption[item]!["option\(i)"]!)", -1, SQLITE_TRANSIENT) != SQLITE_OK {
//                                    let errmsg = String(cString: sqlite3_errmsg(db)!)
//                                    print("failure binding foo: \(errmsg)")
//                                }
//                                print("COLOMN: \(column) VALUE: \(dicQuetionOption[item]!["option\(i)"]!)")
//                                column += 1
//                            }
//                            if sqlite3_bind_text(statement, Int32(column), "\(arrayCorrectAnswer[item])", -1, SQLITE_TRANSIENT) != SQLITE_OK {
//                                let errmsg = String(cString: sqlite3_errmsg(db)!)
//                                print("failure binding foo: \(errmsg)")
//                            }
//                            column += 1
//                            if sqlite3_bind_text(statement, Int32(column), "0", -1, SQLITE_TRANSIENT) != SQLITE_OK {
//                                let errmsg = String(cString: sqlite3_errmsg(db)!)
//                                print("failure binding foo: \(errmsg)")
//                            }
//
//                            if sqlite3_step(statement) != SQLITE_DONE {
//                                let errmsg = String(cString: sqlite3_errmsg(db)!)
//                                print("failure inserting foo: \(errmsg)")
//                            }
//                            else
//                            {
//                                print("Successfuly Insert Data...")
//                            }
//                        }
//
//                    }
//
//    func selectData() {
//        if sqlite3_prepare_v2(db, "select * from questionmaster", -1, &statement, nil) != SQLITE_OK {
//            let errmsg = String(cString: sqlite3_errmsg(db)!)
//            print("error preparing select: \(errmsg)")
//        }
//
//        while sqlite3_step(statement) == SQLITE_ROW {
//            let id = sqlite3_column_int64(statement, 0)
//            print("id = \(id) ", terminator: "")
//
//            if let cString = sqlite3_column_text(statement, 1) {
//
//                let quetion = String(cString: cString)
//                print(" Quetion = \(quetion)")
//            } else {
//                print("quetion not found")
//            }
//
//            if let cString = sqlite3_column_text(statement, 2) {
//                let  option1 = String(cString: cString)
//                print(" option1 = \(option1)" )
//            } else {
//                print("option1 not found")
//            }
//            
//            if let cString = sqlite3_column_text(statement, 3) {
//                let  option2 = String(cString: cString)
//                print(" option2 = \(option2)" )
//            } else {
//                print("option2 not found")
//            }
//            
//            if let cString = sqlite3_column_text(statement, 4) {
//                let  option3 = String(cString: cString)
//                print(" option3 = \(option3)" )
//            } else {
//                print("option3 not found")
//            }
//            
//            if let cString = sqlite3_column_text(statement, 5) {
//                let  option4 = String(cString: cString)
//                print(" option4 = \(option4)" )
//            } else {
//                print("option2 not found")
//            }
//            
//             let currectOption = sqlite3_column_int64(statement, 6)
//            print("currectOption = \(currectOption) ")
//            
//            
//           
//
////            let id = sqlite3_column_int(statement, 0)
////             let name = String(cString: sqlite3_column_text(statement, 1))
////            let mono = String(cString: sqlite3_column_text (statement, 2))
//
////            print("id:\(id) NAME:\(name) MONO: \(mono)")
//        }
//
//
//
//        if sqlite3_finalize(statement) != SQLITE_OK {
//            let errmsg = String(cString: sqlite3_errmsg(db)!)
//            print("error finalizing prepared statement: \(errmsg)")
//        }
//        statement = nil
//    }
//    
//    func quetionDataInitilize() {
//        if sqlite3_prepare_v2(db, "select * from questionmaster", -1, &statement, nil) != SQLITE_OK {
//            let errmsg = String(cString: sqlite3_errmsg(db)!)
//            print("error preparing select: \(errmsg)")
//        }
//
//        while sqlite3_step(statement) == SQLITE_ROW {
//            let id = sqlite3_column_int64(statement, 0)
//            arrayQuetionId.append(Int(id))
//
//            if let cString = sqlite3_column_text(statement, 1) {
//
//                let quetion = String(cString: cString)
//                arrayQuetion.append(quetion)
//            } else {
//                print("quetion not found")
//            }
//
//            if let cString = sqlite3_column_text(statement, 2) {
//                let  option1 = String(cString: cString)
//                arrayoption1.append(option1)
//            } else {
//                print("option1 not found")
//            }
//            
//            if let cString = sqlite3_column_text(statement, 3) {
//                let  option2 = String(cString: cString)
//                arrayoption2.append(option2)
//            } else {
//                print("option2 not found")
//            }
//            
//            if let cString = sqlite3_column_text(statement, 4) {
//                let  option3 = String(cString: cString)
//                arrayoption3.append(option3)
//            } else {
//                print("option3 not found")
//            }
//            
//            if let cString = sqlite3_column_text(statement, 5) {
//                let  option4 = String(cString: cString)
//                arrayoption4.append(option4)
//            } else {
//                print("option2 not found")
//            }
//            
//             let currectOption = sqlite3_column_int64(statement, 6)
//            arrayCurrectAnswer.append(Int(currectOption))
//            
//        }
//        if sqlite3_finalize(statement) != SQLITE_OK {
//            let errmsg = String(cString: sqlite3_errmsg(db)!)
//            print("error finalizing prepared statement: \(errmsg)")
//        }
//        statement = nil
//        
//        print(arrayQuetionId)
//        print(arrayQuetion)
//        print(arrayoption1)
//        print(arrayoption2)
//        print(arrayoption3)
//        print(arrayoption4)
//        print(arrayCurrectAnswer)
//}
//
//}
