//
//  CustomLoginView.swift
//  Calm
//
//  Created by Aarón Cervantes Álvarez on 05/06/21.
//

import SwiftUI
import Firebase
import FirebaseUI

struct CustomLoginView : UIViewControllerRepresentable {
    
    var dismiss : (_ error : Error? ) -> Void
    
    func makeCoordinator() -> CustomLoginView.Coordinator {
        Coordinator(self)
    }
    
    func makeUIViewController(context: Context) -> UIViewController {
        
        let authUI = FUIAuth.defaultAuthUI()
        
        let providers : [FUIAuthProvider] = [
            FUIEmailAuth(),
            FUIGoogleAuth.init(authUI: authUI!),
            FUIFacebookAuth.init(authUI: authUI!),
            FUIOAuth.twitterAuthProvider(),
            FUIOAuth.appleAuthProvider(),
            FUIPhoneAuth.init(authUI: authUI!)
        ]
        
        authUI?.providers = providers
        authUI?.delegate = context.coordinator
        
        let authViewController = authUI?.authViewController()
        
        return authViewController!
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: UIViewControllerRepresentableContext<CustomLoginView>) { }
    
    //coordinator
    class Coordinator : NSObject, FUIAuthDelegate {
        var parent : CustomLoginView
        
        init(_ customLoginViewController : CustomLoginView) {
            self.parent = customLoginViewController
        }
        
        // MARK: FUIAuthDelegate
        func authUI(_ authUI: FUIAuth, didSignInWith authDataResult: AuthDataResult?, error: Error?) {
            if let error = error {
                parent.dismiss(error)
            }
            else {
                parent.dismiss(nil)
            }
        }
        
        func authUI(_ authUI: FUIAuth, didFinish operation: FUIAccountSettingsOperationType, error: Error?) {
        }
    }
}
