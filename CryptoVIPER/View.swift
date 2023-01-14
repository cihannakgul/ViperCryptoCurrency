//
//  View.swift
//  CryptoVIPER
//
//  Created by cihan on 21.11.22.
//

import Foundation
import UIKit

protocol AnyView{
    var presenter : AnyPresenter? {get set}
    func update(with cryptos: [Crypto])
    func update(with error: String)
    
}


class CrpytoViewController : UIViewController, AnyView, UITableViewDelegate, UITableViewDataSource{
 
    var cryptos : [Crypto] = []
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cryptos.count
    }
    
    
    
    private let tableView : UITableView = {
     let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        table.isHidden = true
        return table
    
    }()
    
    private let messageLabel : UILabel = {
       let label = UILabel()
        label.isHidden = false
        label.text = "Wait..."
        label.font = .systemFont(ofSize: 22)
        label.textAlignment = .center
        label.textColor = .black
        return label
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
        view.addSubview(tableView)
        view.addSubview(messageLabel)
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
        messageLabel.frame = CGRect(x: view.frame.width / 2 - 100, y: view.frame.height/2 - 25, width: 200, height: 50)
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        
        print("buraya b \(cryptos[indexPath.row].price)")
        content.text = cryptos[indexPath.row].currency
        content.secondaryText = cryptos[indexPath.row].price
        cell.contentConfiguration = content
        cell.backgroundColor = .yellow
        
        
        
        return cell
    }
    
    
    var presenter: AnyPresenter?
    
    func update(with cryptos: [Crypto]) {
        DispatchQueue.main.async {
            self.cryptos = cryptos
            self.messageLabel.isHidden = true
            self.tableView.reloadData()
            self.tableView.isHidden = false
            
        }
       
        
    }
    
    func update(with error: String) {
        DispatchQueue.main.async {
            self.cryptos = []
            self.messageLabel.text = error
            self.tableView.isHidden = true
        }
    }
    
    
}
