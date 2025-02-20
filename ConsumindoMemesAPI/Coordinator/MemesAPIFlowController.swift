//
//  MemesAPIFlowController.swift
//  ConsumindoMemesAPI
//
//  Created by Jean Ramalho on 19/02/25.
//
import Foundation
import UIKit

class MemesAPIFlowController: CoordinatorProtocol {
    
    private var navigationController: UINavigationController?
    
    public init(){
        
    }
    
    func start() -> UINavigationController {
        
        let contentView = MemesAPISplashView()
        let startViewController = SplashViewController(contentView: contentView, coordinator: self)
        
        self.navigationController = UINavigationController(rootViewController: startViewController)
        
        return navigationController ?? UINavigationController()
        
    }
    
    func showHomeView(){
        let contentView = HomeView()
        let homeView = HomeViewController(contentView: contentView)
        
        self.navigationController?.setViewControllers([homeView], animated: true)
    }
    
}
