//
//  ContentView.swift
//  Habit tracker
//
//  Created by Viachaslau Hryniuk on 11.10.23.
//

import SwiftUI
struct CheckboxStyle: ToggleStyle {
    
    func makeBody(configuration: Self.Configuration) -> some View {

        return HStack {
            Image(systemName: configuration.isOn ? "checkmark.square" : "square")
                .resizable()
                .frame(width: 24, height: 24)
                .foregroundColor(configuration.isOn ? Color("Sec"): .gray)
                .font(.system(size: 20, weight: .regular, design: .default))
                configuration.label
        }
        .onTapGesture { configuration.isOn.toggle() }

    }
}


struct ContentView: View {
    @StateObject var habits = Habits()
    @State private var addHabit = false
    var body: some View {
        NavigationStack{
            ZStack{
                Color("Text")
                    .edgesIgnoringSafeArea(.all)
                               
                VStack{
                    VStack{
                        List {
                            ForEach($habits.items, id: \.self) { $n in
                                NavigationLink{
                                    DescriptionView(totalDays: n.daysGoal, item: n)
                                }
                            label:{
                                Toggle(isOn: $n.isChecked) {
                                    Text(n.name)
                                           }
                                
                                .toggleStyle(CheckboxStyle())
                               
                            }
                            
                           
                            .foregroundColor(.black)
                            .listRowBackground(
                                RoundedRectangle(cornerRadius: 10)
                                    .background(.clear)
                                    .foregroundColor(Color("Cream"))
                                    .padding(
                                        EdgeInsets(
                                            top: 2,
                                            leading: 10,
                                            bottom: 2,
                                            trailing: 10
                                        )
                                    )
                            )
                            .listRowSeparator(.hidden)
                            }
                            
                            .onDelete { idx in
                                habits.items.remove(atOffsets: idx)
                            }
                            
                            
                        }
                        .listStyle(.plain)
                        
                        
                        .background(Color("Text"))
                        .scrollContentBackground(.hidden)
                        .overlay(Group {
                            if(habits.items.isEmpty) {
                                ZStack() {
                                    Color("Text").ignoresSafeArea()
                                 
                                    Text("No habits yet")
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
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Text(Date.now.formatted(date: .abbreviated, time: .omitted))
                }
            }
            
        }
        .accentColor(.black)
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
