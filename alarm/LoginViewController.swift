//
//  LoginViewController.swift
//  alarm
//
//  Created by edmund on 10/1/16.
//  Copyright © 2016 edmund. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, FBSDKLoginButtonDelegate {
    
    let fbLoginBtn : FBSDKLoginButton = FBSDKLoginButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (FBSDKAccessToken.currentAccessToken() != nil) {
            print("Already logged in")
            showFacebookLoginBtn()
            // User is already logged in, do work such as go to next view controller.
        }
        else {
            showFacebookLoginBtn()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Facebook Delegate Methods
    
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        print("User Logged In")
        
        if ((error) != nil)
        {
            // Process error
        }
        else if result.isCancelled {
            // Handle cancellations
            print("canceled")
        }
        else {
            // If you ask for multiple permissions at once, you
            // should check if specific permissions missing
            if result.grantedPermissions.contains("email")
            {
                
                // Do work
                loginUser()
                returnUserData()
            }
        }
    }
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        print("User Logged Out")
    }
    
    func returnUserData() {
        let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "email, name, id"])
        graphRequest.startWithCompletionHandler({ (connection, result, error) -> Void in
            
            if ((error) != nil)
            {
                // Process error
                print("Error: \(error)")
            }
            else
            {
                print(result)
                print(FBSDKAccessToken.currentAccessToken().tokenString)
                print(FBSDKAccessToken.currentAccessToken().expirationDate)
//                let userName : String = result.valueForKey("name") as! String
//                let userEmail : String = result.valueForKey("email") as! String
//                let userId : String = result.valueForKey("id") as! String
            }
        })
    }
    
    func loginUser() {
        let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "email, name, id"])
        graphRequest.startWithCompletionHandler({ (connection, result, error) -> Void in
            if ((error) != nil) {
                // Process error
                print("Error: \(error)")
            }
            else {
                let userName = result.valueForKey("name") as! String
                let userEmail = result.valueForKey("email") as! String
                let userId = result.valueForKey("id") as! String
                let userToken = FBSDKAccessToken.currentAccessToken().tokenString
                let user = User(name: userName, email: userEmail, uid: userId, accessToken: userToken)
                Api.oauthUser(user, completion: self.goToMainView)
            }
        })
    }
    
    func showFacebookLoginBtn() {
        self.view.addSubview(fbLoginBtn)
        fbLoginBtn.center = self.view.center
        fbLoginBtn.readPermissions = ["public_profile", "email", "user_friends"]
        fbLoginBtn.delegate = self
    }
    
    func goToMainView() {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        
        let nextViewController = storyBoard.instantiateViewControllerWithIdentifier("navigationController") as! UINavigationController
        self.presentViewController(nextViewController, animated:true, completion:nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
