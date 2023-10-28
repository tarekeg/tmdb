//
//  Navigator.swift
//  tmbd
//
//  Created by Tarek El Ghoul on 28/10/2023.
//

import UIKit

protocol NavigatorProtocol {
    func toMovieDetail(_ movie: Movie)
}

class Navigator: NavigatorProtocol {
    
    private weak var viewController: UIViewController?
    
    init(_ viewController: UIViewController) {
        self.viewController = viewController
    }
    
    func toMovieDetail(_ movie: Movie) {
        let movieDetailController = UIStoryboard.instantiate(MovieCastsViewController.self, in: "Movies")
        movieDetailController.initialize(with: movie)
        viewController?.navigationController?.pushViewController(movieDetailController, animated: true)
    }
    
}


extension UIStoryboard {
    
    static func instantiate<T: UIViewController>(_ type: T.Type, in storyboardName: String? = nil, storyboardId: String? = nil) -> T {
        let storyboardName: String = storyboardName ?? T.className.deletingSuffix("ViewController")
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        if let viewController = storyboard.instantiateInitialViewController() as? T {
            return viewController
        }
        
        let storyboardId: String = storyboardId ?? T.className
        if let viewController = storyboard.instantiateViewController(withIdentifier: storyboardId) as? T {
            return viewController
        }
        
        fatalError("Could not instantiate \(T.className) identified by \(storyboardId) in \(storyboardName)")
    }
}

extension String {
    func deletingSuffix(_ suffix: String) -> String {
        guard self.hasSuffix(suffix) else {
            return self
        }
        
        return String(self.dropLast(suffix.count))
    }

}

public protocol ClassNameProtocol {
    static var className: String { get }
    var className: String { get }
}

public extension ClassNameProtocol {
    static var className: String {
        String(describing: self)
    }
    
    var className: String {
        type(of: self).className
    }
}

extension NSObject: ClassNameProtocol {
}

