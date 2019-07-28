//
//  SingIn.swift
//  Server Status
//
//  Created by Дмитрий Стариков on 10/07/2019.
//  Copyright © 2019 dmitrystar. All rights reserved.
//

import UIKit


var tempStatus = ServerElement(startupDuration: 100, eventQueueLength: 0, installationDate: "2019-01-22 12:16:22.032", version: "5.70.10", maxMemory: 1, uptime: 1, cpuLoad: 1.1, totalMemory: 1, eventsProcessed: 1, name: "AggreGate Server", cpuLoadSystem: 0.1, startTime: "2019-01-22 12:16:22.032", eventsScheduled: 0, freeMemory: 0, diskUtilization: [DiskUtilization(diskUtilizationName: "5.70.10", diskUtilizationSpace: 0.0)])

let username : UITextField = {
    let textField = UITextField()
    textField.placeholder = "Username"
    textField.borderStyle = .roundedRect
    textField.font = .systemFont(ofSize: 24)
    textField.autocapitalizationType = .none
    textField.autocorrectionType = .no
    textField.returnKeyType = .next
    return textField
}()

let password : UITextField = {
    let textField = UITextField()
    textField.placeholder = "Password"
    textField.borderStyle = .roundedRect
    textField.font = .systemFont(ofSize: 24)
    textField.autocapitalizationType = .none
    textField.autocorrectionType = .no
    textField.isSecureTextEntry = true
    textField.returnKeyType = .next
    return textField
}()

let server : UITextField = {
    let textField = UITextField()
    textField.placeholder = "Server address"
    textField.borderStyle = .roundedRect
    textField.font = .systemFont(ofSize: 24)
    textField.autocapitalizationType = .none
    textField.autocorrectionType = .no
    textField.keyboardType = .URL
    textField.returnKeyType = .continue
    return textField
}()

let connectButton: UIButton = {
    let b = UIButton()
    b.backgroundColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
    b.setTitle("Connect", for: .normal)
    b.titleLabel?.font = .systemFont(ofSize: 30)
    b.layer.cornerRadius = 8
    b.titleLabel?.textColor = .white
    return b
}()

class SingIn: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(username)
        username.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: view.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 150, left: 16, bottom: 0, right: 16))
        
        view.addSubview(password)
        password.anchor(top: username.bottomAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: view.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 32, left: 16, bottom: 0, right: 16))
        
        view.addSubview(server)
        server.anchor(top: password.bottomAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: view.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 32, left: 16, bottom: 0, right: 16))
        
        view.addSubview(connectButton)
        connectButton.anchor(top: server.bottomAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: view.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 100, left: 16, bottom: 0, right: 16), size: .init(width: 0, height: 80))
        
        connectButton.addTarget(self, action: #selector(buttonClicked(sender:)), for: .touchUpInside)
        
    }
    
    @objc private func buttonClicked(sender: UIButton){
        
        //MARK: turn on after test
         if username.text!.isEmpty || password.text!.isEmpty || server.text!.isEmpty {
         popUpAlert(alertMessage: "Enter valid username credimentals and server adress to connect")
         } else {
         let serverUsername = username.text!
         let serverPass = password.text!
         let serverUrl = server.text!
         auth(urlFromUser: serverUrl, user: serverUsername, pass: serverPass)
         }
        
//       performSegue(withIdentifier: "showInfo", sender: nil)
    }
    
    func popUpAlert(alertMessage:String) {
        
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
        let request = NSMutableURLRequest(url: NSURL(string: "\(urlFromUser)/rest/auth")! as URL, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headers
        request.httpBody = (postData as! Data)
        
        let session = URLSession.shared
        
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            
            if let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) {
                if data != nil{
                    let decodedData = try? JSONDecoder().decode(Credimentals.self, from: data!)
                    
                    if decodedData != nil{
                        self.getServerStatus(decodedData!.token, url: urlFromUser)
                    }
                }
            }
            else {
                print("Can't connect")
                
                DispatchQueue.main.async {
                    self.popUpAlert(alertMessage: "Can't connect to server. Enter valid credimentals and try again")
                }
            }

        })
        
        dataTask.resume()
    }
    
    
    
    func getServerStatus(_ token:String, url:String) -> Void {
        
        let headers = ["Authorization": "Bearer" + " " + token]
        
        
        let request = NSMutableURLRequest(url: NSURL(string: "\(url)/rest/v1/contexts/server/variables/status")! as URL, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
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

                        DispatchQueue.main.async {
                            tempStatus = serverData[0]
                            self.performSegue(withIdentifier: "showInfo", sender: nil)
                        }
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
