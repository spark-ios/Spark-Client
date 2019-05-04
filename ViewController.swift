//
//  ViewController.swift
//  Beginner-Constraints
//
//
//

import UIKit
import SVProgressHUD
import Eureka
import Alamofire
import SwiftKeychainWrapper

let uniqueServiceName = "customServiceName"
let uniqueAccessGroup = "sharedAccessGroupName"
let customKeychainWrapperInstance = KeychainWrapper(serviceName: uniqueServiceName, accessGroup: uniqueAccessGroup)
class ViewController: UIViewController {
    
    let URL_SAVE_TEAM = "https://amentechinc.com/spark/iosLogIn.php"
    let defaultValues = UserDefaults.standard
    @IBOutlet weak var password: SATextField!
    @IBOutlet weak var ssd: SATextField!
  
    @IBAction func haha(_ sender: SAButton) {
        
        if (ssd.text?.isEmpty)! || (password.text?.isEmpty)!{
            // create the alert
            let alert = UIAlertController(title: "Error", message: "Email or Password is empty.", preferredStyle: UIAlertController.Style.alert)
            
            // add an action (button)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            
            // show the alert
            self.present(alert, animated: true, completion: nil)
        }
        else{
            //getting the username and password
            let parameters: Parameters=[
                "email":ssd.text!,
                "password":password.text!
            ]
            
            //making a post request
            Alamofire.request(URL_SAVE_TEAM, method: .post, parameters: parameters).responseJSON
                {
                    response in
                    //printing response
                    print(response)
                    
                    //getting the json value from the server
                    if let result = response.result.value {
                        let jsonData = result as! NSDictionary
                        
                        //if there is no error
                        if(!(jsonData.value(forKey: "error") as! Bool)){
                            
                            //getting the user from response
                            let user = jsonData.value(forKey: "user") as? NSDictionary
                            
                            //getting user values
                            let userId = user?.value(forKey: "id") as? Int
                            let userName = user?.value(forKey: "username") as? String
                            let userEmail = user?.value(forKey: "email") as? String
                            let userMobile = user?.value(forKey: "mobile") as? String
                            
                            
                            //saveswiftkeywrapper
                            /*let saveUserid: Bool = customKeychainWrapperInstance.set(userId!, forKey: "userId")
                            let saveUsername: String? = customKeychainWrapperInstance.set(userName, forKey: "userName")
                            let saveUseremail: String? = customKeychainWrapperInstance.set(userEmail, forKey: "userEmail")
                            let saveUsermobile: String? = customKeychainWrapperInstance.set(userMobile, forKey: "userMobile")*/
                            
                            
                            //saving user values to defaults
                            self.defaultValues.set(userId, forKey: "userid")
                            self.defaultValues.set(userName, forKey: "username")
                            self.defaultValues.set(userEmail, forKey: "useremail")
                            self.defaultValues.set(userMobile, forKey: "userphone")
                           
                            //switching the screen
                            let VC = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! SideViewController
                            self.present(VC, animated: true, completion: nil)
                            
                            
                           
                        }else{
                            //error message in case of invalid credential
                            
                            let alert = UIAlertController(title: "Error", message: "Invalid username or password", preferredStyle: UIAlertController.Style.alert)
                            
                            // add an action (button)
                            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                            
                            // show the alert
                            self.present(alert, animated: true, completion: nil)
                        }
                    }
            }
    
    
        }
        
        
    }
   
    let backgroundImageView = UIImageView()
    
   

    override func viewDidLoad() {
        super.viewDidLoad()
        setBackground()
        //ssd.placeholder = ""
        //password.placeholder = ""
        
        let emailImage = UIImage(named:"msg")
        addLeftImageTo(txtField: ssd, andImage: emailImage!)
        
        let passwordImage = UIImage(named:"lock1")
        addLeftImageTo(txtField: password, andImage: passwordImage!)
        
        let passwordImageright = UIImage(named:"icons8hide")
        addRightImageTo(txtField: password, andImage: passwordImageright!)
       
        
    }
    
    func addLeftImageTo(txtField: SATextField, andImage img: UIImage) {
        let leftImageView = UIImageView(frame: CGRect(x: 0.0, y: 0.0, width: 30, height: 25))
        
        let iconContainerView: UIView = UIView(frame:
            CGRect(x: 20, y: 0, width: 30, height: 30))
        iconContainerView.addSubview(leftImageView)
        leftImageView.image = img
        txtField.leftView = leftImageView
        txtField.leftViewMode = .always
    }
    
    func addRightImageTo(txtField: SATextField, andImage img: UIImage) {
        let leftImageView = UIImageView(frame: CGRect(x: 0.0, y: 0.0, width: 22, height: 22))
        
        let iconContainerView: UIView = UIView(frame:
            CGRect(x: 20, y: 0, width: 30, height: 30))
        iconContainerView.addSubview(leftImageView)
        leftImageView.image = img
        txtField.rightView = leftImageView
        txtField.rightViewMode = .always
    }
        
     
    
    
    
    func setBackground() {
        view.addSubview(backgroundImageView)
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        backgroundImageView.image = UIImage(named: "SparkBG")
        view.sendSubviewToBack(backgroundImageView)
    }
    
}

