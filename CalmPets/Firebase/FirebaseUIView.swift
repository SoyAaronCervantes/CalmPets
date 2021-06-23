//
//  FirebaseUIView.swift
//  Calm
//
//  Created by Aarón Cervantes Álvarez on 05/06/21.
//

import SwiftUI
import Firebase
import FirebaseUI

struct FirebaseUIView: View {
    @State private var viewState = CGSize(width: 0, height: screenHeight)
    @State private var MainviewState = CGSize.zero
    
    var body : some View {
        ZStack {
            CustomLoginView { (error) in
                if error == nil {
                    self.status()
                }
            }.offset(y: self.MainviewState.height).animation(.spring())
            ContentView().offset(y: self.viewState.height).animation(.spring())
        }
    }
    
    func status() {
        self.viewState = CGSize(width: 0, height: 0)
        self.MainviewState = CGSize(width: 0, height: screenHeight)
    }
}

struct FirebaseUIView_Previews : PreviewProvider {
    static var previews : some View {
        Group {
            FirebaseUIView().previewDevice("iPhone 11 Pro Max")
            FirebaseUIView().previewDevice("iPhone SE (2nd generation)")
        }
    }
}

public var screenWidth: CGFloat {
    return UIScreen.main.bounds.width
}

public var screenHeight: CGFloat {
    return UIScreen.main.bounds.height
}

