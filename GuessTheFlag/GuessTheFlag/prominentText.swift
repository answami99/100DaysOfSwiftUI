//
//  prominentText.swift
//  GuessTheFlag
//
//  Created by Aditya Narayan Swami on 13/11/21.
//

import SwiftUI

struct prominentTitles: ViewModifier{
    func body(content: Content) -> some View{
        content
            .font(.largeTitle.bold())
            .foregroundColor(.white)
    }
}
extension View{
    func prominentTitle() -> some View{
        modifier(prominentTitles())
    }
}
