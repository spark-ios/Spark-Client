//
//  SignUpViewController.swift
//  Beginner-Constraints
//
//  Created by amentech user on 23/01/2019.
//  Copyright © 2019 Sean Allen. All rights reserved.
//

import UIKit
import Eureka


class SignUpViewController: FormViewController {
    var name: String = ""
    var data: Date? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createSignUpForm()
        
        
        }
        func createSignUpForm(){
            
            form +++ Section("Personal Details")
                
                <<< TextRow(){ row in
                    
                    row.placeholder = "Enter text here"
                    row.tag = "name"
                    
                }
                <<< TextRow(){ row in
                    row.title = "Middle Name"
                    row.placeholder = "Enter text here"
                }
                <<< TextRow(){ row in
                    row.title = "Last Name"
                    row.placeholder = "Enter text here"
                }
                <<< TextRow(){ row in
                    row.title = "Suffix"
                    row.placeholder = "Enter text here"
                }
               
                <<< DateRow(){
                    $0.title = "Birthday"
                    $0.value = Date(timeIntervalSinceReferenceDate: 0)
                }
                <<< ActionSheetRow<String>() {
                    $0.title = "Gender"
                    $0.selectorTitle = "Select"
                    $0.options = ["Male","Female"]
                    $0.value = "Male"    // initially selected
                }
                <<< PhoneRow(){
                    $0.title = "Phone Row"
                    $0.placeholder = "And numbers here"
                }
             +++ Section("Account Details")
                <<< EmailRow(){
                    $0.title = "Email Address"
                    $0.placeholder = "And email here"
                    $0.add(rule: RuleRequired())
                    $0.add(rule: RuleEmail())
                    $0.validationOptions = .validatesOnChangeAfterBlurred
                    }
                    .cellUpdate { cell, row in
                        if !row.isValid {
                            cell.titleLabel?.textColor = .red
                        }
            }
               
                <<< ActionSheetRow<String>() {
                    $0.title = "Car Brand"
                    $0.selectorTitle = "Select"
                    $0.options = ["Acura","BMW","Ford",]
                    $0.value = "Acura"    // initially selected
            }
             
               
                <<< TextAreaRow("") { row in
                    //Row setup
                    row.title = "Car Description"
                    row.placeholder = "Enter text here"
                    
                    }.cellSetup({ (cell, row) in
                        cell.textView.scrollRangeToVisible(NSMakeRange(cell.textView.text.count - 1, 1))
                    }).onChange({ (row) in
                        //Your Change logic
                        
                        row.cell.textView.scrollRangeToVisible(NSMakeRange(row.cell.textView.text.count - 1, 1))
                    })
                <<< TextRow(){
                    $0.title = "Car Plate"
                    $0.placeholder = "Enter text here"
                    }.cellUpdate { cell, row in
                        cell.textField.textAlignment = .left
                }
           +++ Section("")
           
            <<< ButtonRow("register") {
                    $0.title = "Sign up"
                    $0.cell.backgroundColor = .blue
                    $0.cell.tintColor = .white
                
                    }
                    .onCellSelection { cell, row in
                        row.section?.form?.validate()
                        print("gumana register")
                        self.showAlert()
                        
                }.cellUpdate { cell, row in
                    cell.imageView?.image = UIImage(named:"mail")
                }
            +++ Section("")
            animateScroll = true
            // Leaves 20pt of space between the keyboard and the highlighted row after scrolling to an off screen row
            rowKeyboardSpacing = 20
        }
    
        
    @IBAction func showAlert() {
       print(self.name)
        
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
extension BaseRow {
    func selectScrolling(animated: Bool = false) {
        guard let indexPath = indexPath, let tableView = baseCell?.formViewController()?.tableView ?? (section?.form?.delegate as? FormViewController)?.tableView  else { return }
        tableView.selectRow(at: indexPath, animated: animated, scrollPosition: .top)
    }
}
