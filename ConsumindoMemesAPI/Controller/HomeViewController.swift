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
    
    var arrayMemes: [MemeObject] = []
    
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
        
        fetchMemes()
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
    
    
    func fetchMemes() {
        // 1️⃣ Criamos a URL do endpoint da API
        guard let url = URL(string: "https://api.imgflip.com/get_memes") else {
            print("URL inválida")
            return
        }

        // 2️⃣ Criamos uma URLSession para fazer a requisição
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            // 3️⃣ Verificamos se houve erro na requisição
            if let error = error {
                print("Erro na requisição:", error.localizedDescription)
                return
            }
            
            // 4️⃣ Garantimos que a resposta HTTP é válida e tem status 200 (sucesso)
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                
                // 5️⃣ Verificamos se os dados foram recebidos
                guard let data = data else {
                    print("Nenhum dado recebido")
                    return
                }
                
                do {
                    // 6️⃣ Decodificamos os dados JSON no nosso modelo Meme
                    let memeModel = try JSONDecoder().decode(Meme.self, from: data)
                    
                    // 7️⃣ Atualizamos a lista de memes na main thread para refletir na interface
                    DispatchQueue.main.async {
                        self.arrayMemes = memeModel.data.memes
                        self.contentView.memesTableView.reloadData()
                    }
                    
                } catch {
                    // 8️⃣ Capturamos e exibimos erros de decodificação do JSON
                    print("Erro ao decodificar JSON:", error.localizedDescription)
                }
            } else {
                print("Resposta HTTP inválida ou status diferente de 200")
            }
        }
        
        // 9️⃣ Iniciamos a requisição
        task.resume()
    }
    
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrayMemes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MemesTableViewCell.identifier, for: indexPath) as? MemesTableViewCell else {return UITableViewCell()}
        
        cell.memeTitleLabel.text = self.arrayMemes[indexPath.row].name
        
        return cell
    }
    
    
}
