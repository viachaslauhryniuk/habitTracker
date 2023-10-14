//
//  AddHabit.swift
//  Habit tracker
//
//  Created by Слава Гринюк on 11.10.23.
//

import SwiftUI
import ContributionChart
struct AddHabit: View {
    @Environment(\.dismiss) private var dismiss
    @State private var emptyMsgFlag = false
    @State private var name = ""
    @State private var description = ""
    @ObservedObject var habits: Habits
    let time = ["5","10","15","30","60","90","Other"]
    @State private var chosenGoal = ""
    @State private var addInfo = ""
    @State private var other = false
    var body: some View {
        NavigationStack{
            ZStack{
                Rectangle()
                    .fill(Color("Text"))
                    .ignoresSafeArea()
                Rectangle()
                    .fill(.ultraThinMaterial)
                    .ignoresSafeArea()
                VStack(spacing: 25){
                    HStack{
                        Text("Add a new habit")
                            .font(.largeTitle)
                            .fontWeight(.semibold)
                            .padding(20)
                            Spacer()
                        
                    }
                    .padding()
                    Divider()
                    TextField("Name of the habit you want to nail", text: $name )
                        .font(.custom("Big", size: 18))
                        .frame(width: 350,height: 50)
                        .foregroundColor(.black)
                        .background(Color("Cream"))
                        .multilineTextAlignment(.center)
                        .cornerRadius(20)
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color("Sec"), lineWidth: 2)
                        )
                    TextField("    Description and motivation for yourself", text: $description, axis: .vertical )
                        .font(.custom("Big", size: 18))
                        .frame(width: 350,height: 150)
                        .foregroundColor(.black)
                        .background(Color("Cream"))
                        .multilineTextAlignment(.center)
                        .cornerRadius(20)
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color("Sec"), lineWidth: 2)
                        )
                    VStack{
                        Text("Days goal")
                            .foregroundColor(.secondary.opacity(0.5))
                            .font(.body)
                            .fontWeight(.regular)
                            .padding(.top,25)
                        
                        Picker("Days goal", selection: $chosenGoal) {
                            ForEach(time, id: \.self){
                                Text($0)
                            }
                            
                        }
                        .onChange(of: chosenGoal, perform: { _ in
                            onReceive(days: chosenGoal)
                        })
                        .pickerStyle(.segmented)
                        .padding()
                        TextField("Enter amount of days", text: $addInfo )
                            .keyboardType(.decimalPad)
                            .multilineTextAlignment(.center)
                            .isHidden(!other)
                    }
                   
                    .frame(width: 350,height: 175)
                    .background(Color("Cream"))
                    .cornerRadius(20)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color("Sec"), lineWidth: 2)
                    )
                    
                   
        
                    Spacer()
                    Button(action: {
                        if saveHabit() != 1{
                            dismiss()
                        }
                        
                    }, label: {
                        Image(systemName: "checkmark")
                        Text("Save")
                           
                    
                            
                    })
                    
                    .foregroundColor(Color("Text"))
                    .frame(width: 100,height: 50)
                    .background(Color("Sec"))
                    .clipShape(Capsule())
                    
                }
                
            }
            
            
            
        }
        .alert("Fill all of the fields", isPresented: $emptyMsgFlag) {
            Button("OK", role: .cancel){}
        }
        
    }
    func onReceive(days: String){
        if days == "Other"{
            addInfo = ""
            other = true
            
        }
        else{
            other = false
            
        }
    }
    func saveHabit() -> Int{
        
        if !addInfo.isEmpty{
            chosenGoal = addInfo
        }
        if name.isEmpty || description.isEmpty || chosenGoal.isEmpty{
            emptyMsgFlag = true
        }
        guard !emptyMsgFlag else{return 1}
        let habit = Habit(name: name, description: description, daysGoal: Int(chosenGoal) ?? 0)
        habits.items.append(habit)
        return 0
    }
}
extension View {
    @ViewBuilder func isHidden(_ hidden: Bool, remove: Bool = false) -> some View {
        if hidden {
            if !remove {
                self.hidden()
            }
        } else {
            self
        }
    }
}
struct AddHabit_Previews: PreviewProvider {
    static var previews: some View {
        AddHabit(habits: Habits())
    }
}
