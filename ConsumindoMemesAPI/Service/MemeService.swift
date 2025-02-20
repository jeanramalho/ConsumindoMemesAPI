//
//  MemeService.swift
//  ConsumindoMemesAPI
//
//  Created by Jean Ramalho on 20/02/25.
//
import Foundation
import UIKit

class MemeService {
    
    private var arrayMemes: [MemeObject] = []
    

    func countMemes() -> Int {
        self.arrayMemes.count
    }
    
    func getMemeNames(indexPath: IndexPath) -> String {
        return self.arrayMemes[indexPath.row].name
    }
    
    // 🆕 Método para buscar a imagem do meme via URL
    func fetchMemeImage(indexPath: IndexPath, completionHandler: @escaping (UIImage?) -> Void) {
        // 1️⃣ Verifica se existe um meme na posição fornecida
        guard indexPath.row < arrayMemes.count else {
            completionHandler(nil)
            return
        }
        
        // 2️⃣ Obtém a URL da imagem do meme
        let memeUrlString = arrayMemes[indexPath.row].url
        
        // 3️⃣ Converte a string da URL para um objeto URL
        guard let memeUrl = URL(string: memeUrlString) else {
            print("URL da imagem inválida")
            completionHandler(nil)
            return
        }
        
        // 4️⃣ A requisição de download da imagem será feita em uma thread de background
        DispatchQueue.global(qos: .background).async { // 🚀 Iniciamos o download da imagem em background
            // 5️⃣ Criamos uma sessão para baixar a imagem
            let task = URLSession.shared.dataTask(with: memeUrl) { data, response, error in
                
                // 6️⃣ Se houver erro, exibe a mensagem e retorna nil
                if let error = error {
                    print("Erro ao carregar imagem:", error.localizedDescription)
                    DispatchQueue.main.async {
                        completionHandler(nil) // ⬇️ Garantir que a UI seja atualizada na main thread
                    }
                    return
                }
                
                // 7️⃣ Verifica se os dados foram recebidos corretamente
                guard let data = data, let image = UIImage(data: data) else {
                    print("Erro ao converter os dados em imagem")
                    DispatchQueue.main.async {
                        completionHandler(nil) // ⬇️ Garantir que a UI seja atualizada na main thread
                    }
                    return
                }
                
                // 8️⃣ Após o download e conversão da imagem, retornamos para a main thread
                DispatchQueue.main.async {
                    completionHandler(image) // ⬇️ Atualizamos a UI com a imagem na main thread
                }
            }
            
            // 9️⃣ Iniciamos a requisição da imagem
            task.resume()
        }
    }


    
    func getRequestMemes(completionHandler: @escaping(Bool, Error?) -> Void) {
 
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
                        }
                        
                        completionHandler(true, nil)
                        
                    } catch {
                        // 8️⃣ Capturamos e exibimos erros de decodificação do JSON
                        print("Erro ao decodificar JSON:", error.localizedDescription)
                        completionHandler(false, error)
                    }
                } else {
                    print("Resposta HTTP inválida ou status diferente de 200")
                    
                }
            }
            
            // 9️⃣ Iniciamos a requisição
            task.resume()
        }
    
}
