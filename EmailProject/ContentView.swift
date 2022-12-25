//
//  ContentView.swift
//  EmailProject
//
//  Created by Bedirhan Altun on 13.12.2022.
//

import SwiftUI
import GoogleSignIn
import GoogleSignInSwift


struct ContentView: View {
    var body: some View {
        GoogleSignInButton(action: handleSignInButton)
    }
    
    /*
    func check(idToken: String, authCode: String) {
        sendAccessToken(idToken: idToken, authCode: authCode) { messageList in
            guard let mailDataChecked = messageList else { return }
            print(mailDataChecked.messages)

        }
    }
     */
    
    func handleSignInButton() {
        
        var mailList: [Message] = []
        
        
        
        let clientID = "912067323625-i75qh1u2fb7h89ugl0jp8433s8gckccr.apps.googleusercontent.com"
        let config = GIDConfiguration(clientID: clientID, serverClientID: "912067323625-htgebd2uj0o9i9td64vpus52ibv6731s.apps.googleusercontent.com")
        
        GIDSignIn.sharedInstance.signIn(
            with: config,
            presenting: getRootViewController()) { user, error in
                
                let additionalScopes = ["https://www.googleapis.com/auth/gmail.readonly"]
                GIDSignIn.sharedInstance.addScopes(additionalScopes, presenting: getRootViewController()) { user, error in
                    guard error == nil else { return }
                    guard let user = user else { return }
                    
                    // Check if the user granted access to the scopes you requested.
                }
                
                if let error = error {
                    print(error.localizedDescription)
                }
                guard let user = user else { return }
                
                
                
                
                let emailAddress = user.profile?.email
                
                let fullName = user.profile?.name
                let givenName = user.profile?.givenName
                let familyName = user.profile?.familyName
                
                let profilePicUrl = user.profile?.imageURL(withDimension: 320)
                
                let grantedScopes = user.grantedScopes
                print("grantedScopes: \(grantedScopes)")
                
                
                
                sendAccessToken(idToken: user.authentication.idToken ?? "1", authCode: user.serverAuthCode ?? "2", completion: {
                    messagess in
                    print(messagess as Any)
                })
                
                //check(idToken: user.authentication.idToken ?? "1", authCode: user.serverAuthCode ?? "2")
                
                guard user != nil else {
                    // Inspect error
                    return
                }
            }
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension View {
    
    func getRootViewController() -> UIViewController {
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return .init()
            
        }
        
        
        guard let root = screen.windows.first?.rootViewController else { return .init()}
        
        return root
    }
    
    
    func getRoot() -> UIViewController {
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return .init()
            
        }
        
        
        guard let root = screen.windows.first?.rootViewController else { return .init()}
        
        return root
    }
}
