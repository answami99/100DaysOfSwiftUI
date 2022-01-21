//
//  FriendDetailView.swift
//  FriendFace
//
//  Created by Aditya Narayan Swami on 19/01/22.
//

import SwiftUI

struct FriendDetailView: View {
    @FetchRequest var person: FetchedResults<CachedPerson>
    init(friend_id: String){
        _person = FetchRequest(sortDescriptors: [], predicate: NSPredicate(format: "id == %@", friend_id))
    }
    @State private var cardAbout = false
    @State private var cardRotation = false
    @State private var onAppearAnimation = false
    @State private var animationCompleted = false
    @Environment(\.dismiss) var dismiss
    var body: some View {
        
            ZStack{
                Text("Tap on the Card")
                    .offset(y: -150)
                    .foregroundColor(.secondary)
                    .opacity(animationCompleted ? 1 : 0)
                Button{
                    withAnimation(.easeIn){
                        cardAbout.toggle()
                    }
                    withAnimation(.easeOut.speed(0.65)){
                        cardRotation.toggle()
                    }
                } label:{
                    ZStack{
                        RoundedRectangle(cornerRadius: 10)
                            .fill(LinearGradient(gradient: Gradient(colors: [.orange, .yellow]), startPoint: .topLeading, endPoint: .bottomTrailing))
                            .frame(height: 250)
                            .shadow(radius: 8, x: 2, y: 4)
                            
//                        Text("FriendFace")
//                                .font(.system(.caption, design: .rounded)).bold()
//                                .foregroundColor(.gray)
//                                //.frame(maxWidth: .infinity, alignment: .leading)
//                                .frame(maxHeight: 240, alignment: .top)
//                                .padding(5)
                        ForEach(person){ person in
                            if cardAbout{
                               VStack{
                                    Text("About")
                                        .foregroundColor(.black)
    //                                        Spacer()
                                    Text(person.wrappedAbout)
                                        .foregroundColor(.gray)
                                }
                               .rotation3DEffect(Angle.degrees(-180), axis: (0,1,0))
                                .padding()
                            }else{
                                VStack{
                                    HStack{
                                        Text("Name")
                                            .foregroundColor(.black)
                                        Spacer()
                                        Text(person.wrappedName)
                                            .foregroundColor(.gray)
                                    }
                                    Divider()
                                    HStack{
                                        Text("Age")
                                            .foregroundColor(.black)
                                        Spacer()
                                        Text("\(person.age)")
                                            .foregroundColor(.gray)
                                    }
                                    Divider()
                                    HStack{
                                        Text("Company")
                                            .foregroundColor(.black)
                                        Spacer()
                                        Text(person.wrappedCompany)
                                            .foregroundColor(.gray)
                                    }
                                    Divider()
                                    HStack{
                                        Text("Email")
                                            .foregroundColor(.black)
                                        Spacer()
                                        Text(person.wrappedEmail)
                                            .foregroundColor(.gray)
                                    }
                                    Divider()
                                    HStack{
                                        Text("Address")
                                            .foregroundColor(.black)
                                        Spacer()
                                        Text(person.wrappedAddress)
                                            .foregroundColor(.gray)
                                    }
                                }
                                .padding()
                            }
                        }
                }
                .rotation3DEffect(onAppearAnimation ? Angle.degrees(360) : Angle.degrees(0), axis: (1, 0, 0))
                .offset(y: onAppearAnimation ? 0 : 500)
                .rotation3DEffect(cardRotation ? Angle.degrees(180) : Angle.degrees(0), axis: (0, 1, 0))
                .padding()
            }
            
            Button("Done"){
                dismiss()
            }
            .frame(maxHeight: .infinity, alignment: .bottom)
            .onAppear{
                withAnimation(.interpolatingSpring(stiffness: 40.0, damping: 8.0)){
                    onAppearAnimation = true
                }
                withAnimation(.easeIn.delay(1)){
                    animationCompleted = true
                }
            }
        }
    }
}

struct FriendDetailView_Previews: PreviewProvider {
    static var previews: some View {
        FriendDetailView(friend_id: "")
    }
}
