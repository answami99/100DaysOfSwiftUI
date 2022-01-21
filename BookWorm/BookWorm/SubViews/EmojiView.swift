//
//  EmojiView.swift
//  BookWorm
//
//  Created by Aditya Narayan Swami on 30/12/21.
//

import SwiftUI

struct EmojiView: View {
    var rating: Int16
    var body: some View {
        switch rating {
        case 1:
            Text("1")
        case 2:
            Text("2")
        case 3:
            Text("3")
        case 4:
            Text("4")
        default:
            Text("5")
        }
    }
}

struct EmojiView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiView(rating: Int16(5))
    }
}
