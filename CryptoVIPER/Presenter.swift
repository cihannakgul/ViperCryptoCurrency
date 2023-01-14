//
//  Presenter.swift
//  CryptoVIPER
//
//  Created by cihan on 21.11.22.
//

import Foundation

enum NetworkError : Error{
    case NetworkError
    case ParsingFailed
}

protocol AnyPresenter{
    
    var router : AnyRouter? {get set}
    var interactor : AnyInteractor? {get set}
    var view: AnyView? {get set}
    
    func interactorDidDownloadCryptos(result: Result<[Crypto], Error>)
}


class CryptoPresenter : AnyPresenter{
    
    
    var view: AnyView?
    
    var router: AnyRouter?
    
    var interactor: AnyInteractor?{
        didSet{
            interactor?.downloadCryptos()
        }
    }
    
    
    func interactorDidDownloadCryptos(result: Result<[Crypto], Error>) {
      
        switch result{
        case .failure(let error):
            view?.update(with: "Erro")
        case.success(let cryptos):
            view?.update(with: cryptos)
        }
    }
}
