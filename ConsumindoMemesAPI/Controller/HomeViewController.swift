//
//  HomeViewController.swift
//  ConsumindoMemesAPI
//
//  Created by Jean Ramalho on 19/02/25.
//
import Foundation
import UIKit

class HomeViewController: UIViewController {
    
    let contentView: HomeView
    
    var memeService: MemeService = MemeService()
    
    init(contentView: HomeView) {
        self.contentView = contentView
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup(){
        
        
        contentView.memesTableView.delegate = self
        contentView.memesTableView.dataSource = self
        
        memeService.getRequestMemes { response, error in
            if response {
                
                // Garanta que a UI seja atualizada na thread principal
                     DispatchQueue.main.async {
                         self.contentView.memesTableView.reloadData()
                     }
            } else {
                print(error ?? "Erro ao realizar request")
            }
        }
        setHierarchy()
        setConstraints()
    }
    
    private func setHierarchy(){
        view.addSubview(contentView)
    }
    
    private func setConstraints(){
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: view.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    
    
    
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memeService.countMemes()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MemesTableViewCell.identifier, for: indexPath) as? MemesTableViewCell else {return UITableViewCell()}
        
        // 1️⃣ Define o título do meme
        cell.memeTitleLabel.text = self.memeService.getMemeNames(indexPath: indexPath).uppercased()
        
        // 2️⃣ Configura uma imagem temporária para evitar imagens erradas ao reciclar células
           cell.memeImageView.image = UIImage(systemName: "photo")

        // 3️⃣ Busca a imagem da API
         self.memeService.fetchMemeImage(indexPath: indexPath) { image in
             DispatchQueue.main.async { // ⬇️ Atualização da UI sempre na main thread
                 if let currentIndex = tableView.indexPath(for: cell), currentIndex == indexPath {
                     cell.memeImageView.image = image
                 }
             }
         }
        
        return cell
    }
    
    
}
