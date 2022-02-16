//
//  AppDelegate.swift
//  NewsApi-OrangeTask
//
//  Created by Abdallah on 2/13/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        rootViewController()
        checkNetworkConnection()
        return true
    }
    // check Networking and notify it
    fileprivate func checkNetworkConnection() {
        do {
            try Network.reachability = Reachability(hostname: "www.google.com")
        }
        catch {
            switch error as? Network.Error {
            case let .failedToCreateWith(hostname)?:
                print("Network error:\nFailed to create reachability object With host named:", hostname)
            case let .failedToInitializeWith(address)?:
                print("Network error:\nFailed to initialize reachability object With address:", address)
            case .failedToSetCallout?:
                print("Network error:\nFailed to set callout")
            case .failedToSetDispatchQueue?:
                print("Network error:\nFailed to set DispatchQueue")
            case .none:
                print(error)
            }
        }
    }
    
    fileprivate func rootViewController() {
        if UserDefaults.standard.string(forKey: Constant.countryName) != nil {
            let storyboard = UIStoryboard(name: Constant.mainHeadLineNews, bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier: Constant.headLineNewsVC)
            let nav = UINavigationController(rootViewController: viewController)
            window?.rootViewController = nav
            window?.makeKeyAndVisible()
            print("userDefault has a value")
        } else {
            print("userDefault is nil (empty)")
            
            let storyboard = UIStoryboard(name: Constant.main, bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier:Constant.CountryVC)
            let nav = UINavigationController(rootViewController: viewController)
            window?.rootViewController = nav
            window?.makeKeyAndVisible()
        }
    }
    
}


