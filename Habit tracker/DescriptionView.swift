//
//  DescriptionView.swift
//  Habit tracker
//
//  Created by Слава Гринюк on 16.10.23.
//

import SwiftUI

struct DescriptionView: View {
    var item:Habit
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        NavigationStack{
            ZStack{
                Color("Text")
                    .edgesIgnoringSafeArea(.all)
              
                
                VStack{
                    Divider()
                    HStack{
                        Text(item.name)
                            .font(.title)
                            .fontWeight(.heavy)
                            .padding()
                        
                        Spacer()
                    }
                    HStack{
                        Text(item.description)
                            .fontWeight(.heavy)
                            .padding(.horizontal,18)
                        Spacer()
                    }
                    Spacer()
                }
                
                .navigationBarBackButtonHidden(true)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(action: {
                            dismiss()
                        }) {
                            Label("Back", systemImage: "arrow.left.circle")
                            
                        }
                    }
                    
                }
            }
            .navigationTitle("Habit Details")
        }
        
    }
}

struct DescriptionView_Previews: PreviewProvider {
    static var previews: some View {
        DescriptionView(item: Habit(name: "TestName", description: "Test description", daysGoal: 0))
    }
}
