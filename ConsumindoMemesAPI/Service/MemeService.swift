//
//  MemeService.swift
//  ConsumindoMemesAPI
//
//  Created by Jean Ramalho on 20/02/25.
//
import Foundation

class MemeService {
    
    private var arrayMemes: [MemeObject] = []
    

    func countMemes() -> Int {
        self.arrayMemes.count
    }
    
    func getMemeNames(indexPath: IndexPath) -> String {
        return self.arrayMemes[indexPath.row].name
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
