//
//  AppDelegate.swift
//  Parstagram
//
//  Created by Julianna Cardenas on 2/6/21.
//

import UIKit
import Parse

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

//    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let configuration = ParseClientConfiguration {
            $0.applicationId = "lbArkV9UcFU8BIpyeUVEaCoebELr7z7zJWWy2JYP"
            $0.clientKey = "rQbnq5vNYvNE0gNBMVITtFP2w1u5wHfVffyNGb9e"
            $0.server = "https://parseapi.back4app.com"
        }
        Parse.initialize(with: configuration)
        
        saveInstallationObject()
        
//        if PFUser.current() != nil {
//            let main = UIStoryboard(name: "Main", bundle: nil)
//            let feedNavigationController = main.instantiateViewController(identifier: "FeedNavigationController")
//
//            window?.rootViewController = feedNavigationController
//
//        }
        
        return true
    }

    func saveInstallationObject(){
        if let installation = PFInstallation.current(){
            installation.saveInBackground {
                (success: Bool, error: Error?) in
                if (success) {
                    print("You have successfully connected your app to Back4App!")
                } else {
                    if let myError = error{
                        print(myError.localizedDescription)
                    }else{
                        print("Uknown error")
                    }
                }
            }
        }
    }
    
    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

