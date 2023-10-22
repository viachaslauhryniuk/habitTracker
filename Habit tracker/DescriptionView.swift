//
//  DescriptionView.swift
//  Habit tracker
//
//  Created by Слава Гринюк on 16.10.23.
//

import SwiftUI
import GithubSwiftCharts
struct DescriptionView: View {
    let contributionData:[String: Int]
    let daysPerRow:Int = 23
    let totalDays:Int = 92
    var item:Habit
    init(totalDays: Int, item: Habit) {
        self.item = item
        self.contributionData = item.daysCount
    }
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
                    HStack{
                        Text("Days Goal: \(item.daysGoal)")
                            .fontWeight(.heavy)
                            .padding(.horizontal,18)
                            .padding(.vertical,18)
                        Spacer()
                    }
                    Spacer()
                    Text("Days Active: \(item.daysCount.count)")
                    ContributionChartView(contributionData: contributionData, daysPerRow: daysPerRow, totalDays: totalDays)
                    
                    
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
        DescriptionView(totalDays: 90, item: Habit(name: "TestName", description: "Test description", daysGoal: 180,daysCount: ["2023-10-19": 3,"2023-10-18": 4]))
    }
}
