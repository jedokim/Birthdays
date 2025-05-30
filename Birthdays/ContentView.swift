//
//  ContentView.swift
//  Birthdays
//
//  Created by Jeremy Kim on 5/9/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Query(sort: \Friend.birthday, order: .reverse) private var friends: [Friend]
    @Environment(\.modelContext) private var context
    
    @State private var newName: String = ""
    @State private var newDate: Date = .now
    
    var body: some View {
        NavigationStack {
            VStack {
                List(friends) { friend in
                    HStack {
                        if (friend.isBirthdayToday) {
                            Image(systemName: "birthday.cake")
                        }
                        Text(friend.name)
                        Spacer()
                        Text(friend.birthday, style: .date)
                    }
                }
            }
            .navigationTitle("Birthdays")
            .safeAreaInset(edge: .bottom) {
                VStack (alignment: .center, spacing: 20) {
                    Text("New Birthday")
                        .font(.headline)
                    DatePicker(selection: $newDate,
                               in: Date.distantPast...Date.now,displayedComponents: .date) {
                        TextField("Name", text: $newName)
                            .textFieldStyle(.roundedBorder)
                    }
                    Button("Save") {
                        let newFriend = Friend(name: newName, birthday: newDate)
                        context.insert(newFriend)
                        
                        newName = ""
                        newDate = .now
                    }
                    .bold()
                }
                .padding()
                .background(.bar)
            }
//            .task { // pre populates data
//                context.insert(Friend(name: "Jeremy Kim", birthday: .now))
//                context.insert(Friend(name: "Jedo Kim", birthday: Date(timeIntervalSince1970: 0)))
//            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Friend.self, inMemory: true)
}
