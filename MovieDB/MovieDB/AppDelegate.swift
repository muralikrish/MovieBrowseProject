//
//  AppDelegate.swift
//  MovieDB
//
//  Created by Teja Bethina on 6/1/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let moviesVC = storyboard.instantiateViewController(withIdentifier: "MovieListVC")
        let navController = UINavigationController(rootViewController: moviesVC)
        navController.navigationBar.isTranslucent = false
        setNavBArStyles()
        window = UIWindow()
        window?.rootViewController = navController
        window?.makeKeyAndVisible()
        
        return true
    }
    
    private func setNavBArStyles() {
        UINavigationBar.appearance().barTintColor = UIColor(red: 59/255, green: 89/255, blue: 152/255, alpha: 1)
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        UINavigationBar.appearance().tintColor = UIColor.white
    }
}

