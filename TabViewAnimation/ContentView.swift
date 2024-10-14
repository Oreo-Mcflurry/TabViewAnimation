//
//  ContentView.swift
//  TabViewAnimation
//
//  Created by Musk on 9/12/24.
//

import SwiftUI

struct ContentView: View {
    @State var selectedTab: StatisticsPages = .today
    let data: [(Date, [CustomModel])] = [
           (Date(), [
               CustomModel(title: "Title 1", description: "Description 1"),
               CustomModel(title: "Title 2", description: "Description 2")
           ]),
           (Date().addingTimeInterval(86400), [
               CustomModel(title: "Title 3", description: "Description 3"),
               CustomModel(title: "Title 4", description: "Description 4")
           ])
       ]
        
    
    var body: some View {
        VStack {
            HStack {
                ForEach(StatisticsPages.allCases, id: \.self) { item in
                    Button {
                        withAnimation {
                            selectedTab = item
                        }
                    } label: {
                        Text("\(item.tabName) Button")
                    }
                }
            }
            
            TabView(selection: $selectedTab) {
                generateTabContent(with: data).tag(StatisticsPages.today)
                generateTabContent(with: data).tag(StatisticsPages.week)
                generateTabContent(with: data).tag(StatisticsPages.month)
                generateTabContent(with: data).tag(StatisticsPages.dateSelection)
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
        }
    }
    
    @ViewBuilder
    func generateTabContent(with data: [(Date, [CustomModel])]) -> some View {
        if Bool.random() {
            Text("False")
        } else {
            ScrollView {
                LazyVStack {
                    ForEach(Array(data.enumerated()), id: \.0) { index, data in
                        VStack(alignment: .leading) {
                            Text("Date: \(data.0, formatter: dateFormatter)")
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .font(.headline)
                                .padding(.bottom)
                            
                            ForEach(data.1) { model in
                                VStack(alignment: .leading) {
                                    Text(model.title)
                                        .font(.title2)
                                    Text(model.description)
                                        .font(.subheadline)
                                }
                                .padding(.bottom)
                            }
                        }
                        .padding()
                    }
                }
            }
        }
    }

   
    var dateFormatter: DateFormatter {
          let formatter = DateFormatter()
          formatter.dateStyle = .medium
          return formatter
      }
   
}

#Preview {
    ContentView()
}

struct CustomModel: Identifiable {
    let id = UUID() // Identifiable을 준수하기 위해 id 필요
    let title: String
    let description: String
}

enum StatisticsPages: Int, CaseIterable, Equatable {
    case today = 0
    case week
    case month
    case dateSelection

    var tabName: String {
        switch self {
        case .today:
            return "Today"
        case .week:
            return "Week"
        case .month:
            return "Month"
        case .dateSelection:
            return "Date selection"
        }
    }
}
