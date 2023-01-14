//
//  Router.swift
//  CryptoVIPER
//
//  Created by cihan on 21.11.22.
//

import Foundation
import UIKit

typealias EntryPoint = UIViewController & AnyView


protocol AnyRouter {
    var entry : EntryPoint? {get}
    static func startExecution() -> AnyRouter
}

class CryptoRouter :AnyRouter{
    var entry: EntryPoint?
    
     static func startExecution() -> AnyRouter {
        
         let router = CryptoRouter()
         var view : AnyView = CrpytoViewController()
         var interactor : AnyInteractor = CryptoInteractor()
         var presenter : AnyPresenter = CryptoPresenter()
         
         view.presenter = presenter
         
         presenter.view = view
         presenter.interactor = interactor
         presenter.router = router
         interactor.presenter = presenter
         router.entry = view as? EntryPoint
         
         
         
         return router
    }
    
    
}
