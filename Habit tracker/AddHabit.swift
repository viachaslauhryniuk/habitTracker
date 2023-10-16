//
//  AddHabit.swift
//  Habit tracker
//
//  Created by Viachaslau Hryniuk on 11.10.23.
//

import SwiftUI
import ContributionChart
struct AddHabit: View {
    @ObservedObject var habits: Habits
    @State private var name = ""
    @State private var description = ""
    let time = ["5","10","15","30","60","90","Other"]
    @State private var chosenGoal = "" // Chosen goal from array above
    @State private var other = false // Other element flag
    @State private var addInfo = "" // Custom goal
    @FocusState var isInputActive: Bool // Description textfield focus
    @FocusState private var campaignTitleIsFocussed: Bool // Date textfield focus
    @State private var emptyMsgFlag = false // Empty alert flag
    @Environment(\.dismiss) private var dismiss
   
    var body: some View {
      
            ZStack{
                Rectangle()
                    .fill(Color("Text"))
                    .ignoresSafeArea()
                Rectangle()
                    .fill(.ultraThinMaterial)
                    .ignoresSafeArea()
                
                VStack(spacing: 25) { // main VStack with all stuff
                    HStack{ // Title text
                        Text("Add a new habit")
                            .font(.largeTitle)
                            .fontWeight(.semibold)
                            .padding(20)
                        Spacer()
                        
                    }
                    .padding()
                    // ------------
                    
                    Divider()
                    
                    
                    TextField("Name of the habit you want to nail", text: $name ) //Textfield for name
                        .font(.custom("Big", size: 18))
                        .frame(width: 350,height: 50)
                        
                        .foregroundColor(.black)
                        .background(Color("Cream"))
                        .multilineTextAlignment(.center)
                        .submitLabel(.done)
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color("Sec"), lineWidth: 2)
                        )
                        .cornerRadius(20)
                    
                    
                    
                    
                    TextField("    Description and motivation for yourself", text: $description, axis: .vertical ) //TextField for description
                        .font(.custom("Big", size: 18))
                        .frame(width: 350,height: 150)
                        
                        .foregroundColor(.black)
                        .background(Color("Cream"))
                        .multilineTextAlignment(.center)
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color("Sec"), lineWidth: 2)
                        )
                        .cornerRadius(20)
                        .focused($campaignTitleIsFocussed)
                        .onChange(of: description) { newValue in
                            guard let newValueLastChar = newValue.last else { return }
                            if newValueLastChar == "\n" {
                                description.removeLast()
                                campaignTitleIsFocussed = false
                            }
                        }
                        .submitLabel(.done)
                       
                        //----------
                       
                    NavigationStack{
                        ZStack{
                            Rectangle()
                                .fill(Color("Cream"))
                                .ignoresSafeArea()
                        
                            
                            
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
                                .padding()
                                .onChange(of: chosenGoal, perform: { _ in
                                    onReceive(days: chosenGoal)
                                })
                                .pickerStyle(.segmented)
                                
                                
                                
                                
                                TextField("Enter amount of days", text: $addInfo )
                                    .keyboardType(.decimalPad)
                                    .multilineTextAlignment(.center)
                                    .submitLabel(.done)
                                    .isHidden(!other)
                                    .focused($isInputActive)
                                    .toolbar {
                                        ToolbarItemGroup(placement: .keyboard) {
                                          
                                            
                                            Button("Done") {
                                                isInputActive = false
                                            }
                                        }
                                    }
                                
                                
                                
                                
                            } //VStack ends
                        } //ZStack ends
                    
                    }//NavStack Ends
                    .frame(width: 350,height: 175)
                    .background(Color("Cream"))
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color("Sec"), lineWidth: 2)
                    )
                    .cornerRadius(20)
                    
                    
                    Spacer()
                    
                    
                    
                    
                    Button(action: { //Save button
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
                    
                }// Main VStack ends
                
            }
            
            
            
        
        .alert("Fill all of the fields", isPresented: $emptyMsgFlag) {
            Button("OK", role: .cancel){}
        }
        
    } // Body ends here
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
