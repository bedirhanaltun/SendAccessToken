//
//  SendAccessToken.swift
//  EmailProject
//
//  Created by Bedirhan Altun on 13.12.2022.
//

import UIKit

func sendAccessToken(idToken: String, authCode: String, completion: @escaping (MessageList?) -> Void) {
    
    guard let url = URL(string: "http://192.168.16.111:8080/user/verifyUser") else { return }
    
    var mailRequest = URLRequest(url: url)
    mailRequest.httpMethod = "POST"
    mailRequest.allHTTPHeaderFields = ["idToken": idToken, "authCode": authCode]
    
    URLSession.shared.dataTask(with: mailRequest) { data, response, error in
        
        if let error = error {
            DispatchQueue.main.async {
                completion(nil)
            }
        }
        
        guard let response = response as? HTTPURLResponse else {
            DispatchQueue.main.async {
                completion(nil)
            }
            return
        }
        
        guard let data = data else {
            DispatchQueue.main.async {
                completion(nil)
            }
            return
            
        }
        
        do{
            let inventoryCheckResponse = try JSONDecoder().decode(MessageList.self, from: data)
            DispatchQueue.main.async {
                completion(inventoryCheckResponse)
            }
        }
        catch{
            DispatchQueue.main.async {
                completion(nil)
            }
        }

    }
    .resume()
}
