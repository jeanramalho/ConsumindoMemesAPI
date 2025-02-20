//
//  HomeView.swift
//  ConsumindoMemesAPI
//
//  Created by Jean Ramalho on 19/02/25.
//
import Foundation
import UIKit

class HomeView: UIView {
    
    lazy var headerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .orange
        view.layer.cornerRadius = 8
        return view
    }()
    
    lazy var memesTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Consumindo API de Memes"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 28)
        return label
    }()
    
    lazy var memesTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(MemesTableViewCell.self, forCellReuseIdentifier: MemesTableViewCell.identifier)
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI(){
        
        setHierarchy()
        setConstraints()
    }
    
    private func setHierarchy(){
        addSubview(headerView)
        addSubview(memesTableView)
        
        headerView.addSubview(memesTitleLabel)
    }
    
    private func setConstraints(){
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: topAnchor),
            headerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 150),
            
            memesTitleLabel.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            memesTitleLabel.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -32),
            
            memesTableView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            memesTableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            memesTableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            memesTableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
        ])
    }
}
