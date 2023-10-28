//
//  AppDelegate.swift
//  tmbd
//
//  Created by Tarek El Ghoul on 27/10/2023.
//

import UIKit
import Resolver

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window:UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window?.rootViewController = UIStoryboard(name: "Movies", bundle: nil).instantiateInitialViewController()
        window?.makeKeyAndVisible()

        return true
    }

}


extension Resolver: ResolverRegistering {
    
    public static func registerAllServices() {
        registerDataProviders()
        registerManagers()
        registerViewModels()
    }
    
}

private extension Resolver {
    
    static func registerDataProviders() {
        register { createMovieProvider() }
    }
    
    static func registerManagers() {
        register { MovieManager(movieProvider: resolve()) as MovieManagerProtocol }
    }
    
    static func registerViewModels() {
        register { _, args in Navigator(args()) as NavigatorProtocol }
        register { _, args in PopularMoviesViewModel(navigator: resolve(args: args)) }
    }
    
    static func createMovieProvider() -> MovieProviderProtocol {
        return MovieProvider() as MovieProviderProtocol
    }
    
    
    
}
