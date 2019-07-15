//
//  SingIn.swift
//  Server Status
//
//  Created by Дмитрий Стариков on 10/07/2019.
//  Copyright © 2019 dmitrystar. All rights reserved.
//

import UIKit

class SingIn: UIViewController {
    
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var server: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func connect(_ sender: UIButton) {
        //need  to validate data first
        
        if username.text!.isEmpty || password.text!.isEmpty || server.text!.isEmpty {
            popUpAlert(alertMessage: "Enter valid username credimentals and server adress to connect")
        } else {
            let serverUsername = username.text!
            let serverPass = password.text!
            let serverUrl = server.text!
            auth(urlFromUser: serverUrl, user: serverUsername, pass: serverPass)
        }
        
        
        //call rest api func
        // segue to another view
    }
    
    func popUpAlert(alertMessage:String) -> Void {
        
        let alert = UIAlertController(title: "Alert", message: alertMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            switch action.style{
            case .default:
                print("default")
                
            case .cancel:
                print("cancel")
                
            case .destructive:
                print("destructive")
                
            }}))
        self.present(alert, animated: true, completion: nil)
        
    }
    
    
    func auth(urlFromUser: String, user: String, pass: String) {
        
        let headers = ["Content-Type": "application/json"]
        let parameters = ["username": user, "password": pass] as [String : Any]

        let postData = try? JSONSerialization.data(withJSONObject: parameters, options: [])

        let request = NSMutableURLRequest(url: NSURL(string: "http://10.0.1.7:8080/rest/auth")! as URL, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headers
        request.httpBody = postData as! Data
        
        let session = URLSession.shared
        
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            
            if let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) {
                if data != nil{
                    let decodedData = try? JSONDecoder().decode(Credimentals.self, from: data!)
                    
                    if decodedData != nil{
                        self.getServerStatus(decodedData!.token)
                    }
                }
            }
            else {
                print("Can't connect")
                self.popUpAlert(alertMessage: "Can't connect to server. Enter valid credimentals and try again")
            }

        })
        
        dataTask.resume()
    }
    
    
    
    func getServerStatus(_ token:String) -> Void {
        
        let headers = ["Authorization": "Bearer" + " " + token]
        
  //      http://10.0.1.7:8080/rest/v1/contexts/server/variables/status
        
        let request = NSMutableURLRequest(url: NSURL(string: "http://10.0.1.7:8080/rest/v1/contexts/server/variables/status")! as URL, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                print(error ?? 0)
            }
            if let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode){
                if data != nil{
                    print(data!)
                    do {
                        let serverData = try JSONDecoder().decode(Server.self, from: data!)
                        print(serverData[0].name)
                    } catch let error{
                        print(error)
                    }
                }else{
                    print("smth was wrong")
                }
            } else {
                print("can't autorize")
            }


        })
        
        dataTask.resume()
    }
}
