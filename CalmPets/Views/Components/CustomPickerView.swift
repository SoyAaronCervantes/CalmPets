//
//  CustonPickerView.swift
//  calmvet
//
//  Created by Aarón Cervantes Álvarez on 29/05/21.
//

import SwiftUI

struct CustomPickerView: View {
    private let placeholder: String
    private let list: [String]
    @Binding var index: Int

    init(_ placeholder: String, _ list: [String], index: Binding<Int>) {
        self.placeholder = placeholder
        self.list = list
        self._index = index
    }
    
    var body: some View {
        Picker(placeholder, selection: $index) {
            ForEach(0 ..< list.count) { i in
                Text( list[i] )
            }
        }
    }
}

