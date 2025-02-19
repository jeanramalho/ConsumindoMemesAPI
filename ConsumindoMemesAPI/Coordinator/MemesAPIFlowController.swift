//
//  MemesAPIFlowController.swift
//  ConsumindoMemesAPI
//
//  Created by Jean Ramalho on 19/02/25.
//
import Foundation
import UIKit

class MemesAPIFlowController {
    
    private var navigationController: UINavigationController?
    
    public init(){
        
    }
    
    func start() -> UINavigationController {
        
        let contentView = MemesAPISplashView()
        let startViewController = SplashViewController(contentView: contentView)
        
        self.navigationController = UINavigationController(rootViewController: startViewController)
        
        return navigationController ?? UINavigationController()
        
    }
}
