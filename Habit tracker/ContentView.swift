//
//  ContentView.swift
//  Habit tracker
//
//  Created by Слава Гринюк on 11.10.23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var habits = Habits()
    @State private var addHabit = false
    var body: some View {
        NavigationStack{
            ZStack{
                Color("Text")
                    .edgesIgnoringSafeArea(.all)
                Rectangle()
                    .fill(.ultraThinMaterial)
                    .ignoresSafeArea()
                VStack{
                    VStack{
                        List(){
                          
                            ForEach(habits.items, id: \.self){ item in
                                Text(item.name)
                            }
                            .listRowBackground(Color("Cream"))
                        }
                        .background(Color("Text"))
                        .scrollContentBackground(.hidden)
                        .overlay(Group {
                            if(habits.items.isEmpty) {
                                ZStack() {
                                    Color("Text").ignoresSafeArea()
                                    Text("No hobits yet")
                                }
                            }
                    })
                      
                        .navigationTitle("Your Habits")
                    }
                    Spacer()
                    HStack{
                        Button(action: {
                            addHabit = true
                        }, label: {
                            Image(systemName: "note.text.badge.plus")
                                .foregroundColor(Color("Text"))
                                .frame(width: 100,height: 50)
                                .background(Color("Sec"))
                                .clipShape(Capsule())
                            
                            
                        })
                        .sheet(isPresented: $addHabit, content: {
                            AddHabit(habits: habits)
                                .presentationDragIndicator(.visible)
                            
                        })
                        
                    }
                    
                }
                
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
