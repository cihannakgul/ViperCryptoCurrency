//
//  Interactor.swift
//  CryptoVIPER
//
//  Created by cihan on 21.11.22.
//

import Foundation


protocol AnyInteractor{
    
    var presenter : AnyPresenter? {get set}
    func downloadCryptos()
}

class CryptoInteractor : AnyInteractor{
    var presenter: AnyPresenter?
    
    func downloadCryptos() {
        guard let url = URL(string:"https://raw.githubusercontent.com/atilsamancioglu/K21-JSONDataSet/master/crypto.json")
        else{
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
          
            guard let data = data, error == nil else{
                self.presenter?.interactorDidDownloadCryptos(result: .failure(NetworkError.NetworkError))
                return
            }
            
            do{
                let cryptos = try JSONDecoder().decode([Crypto].self, from: data)
                self.presenter?.interactorDidDownloadCryptos(result: .success(cryptos))
                
            }catch{
                self.presenter?.interactorDidDownloadCryptos(result: .failure(NetworkError.ParsingFailed))
            }
        }
        task.resume()
    }
    
    
}
