//
//  ProfileView.swift
//  flight-log-ios
//
//  Created by Johannes Scribante on 2022/12/30.
//

import SwiftUI

struct ProfileView: View {
    @FetchRequest(sortDescriptors: [])
    private var users: FetchedResults<User>
    
    var user: User {
        users[0]
    }
    
    @State private var showEditProfile = false
    
    var body: some View {
        VStack {
            VStack {
                HStack {
                    Image(systemName: "airplane.circle.fill")
                        .font(.largeTitle)
                    Spacer()
                }
                Spacer()
                HStack {
                    Text("Pilot")
                    Spacer()
                    Text("\(user.unwrappedFirstName) \(user.unwrappedLastName)")
                }
                HStack {
                    Text("License Number")
                    Spacer()
                    Text(user.unwrappedLicenseNumber)
                }
            }
            .frame(height: 150)
            .frame(maxWidth: 300)
            .padding()
            .background(LinearGradient(colors: [.blue, .green], startPoint: .topLeading, endPoint: .bottomTrailing))
            .foregroundColor(.white)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .shadow(radius: 8)
            
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Text("First name: \(user.unwrappedFirstName)")
                    Spacer()
                }
                Text("Last name: \(user.unwrappedLastName)")
                Text("Email: \(user.unwrappedEmail)")
                Text("License Number: \(user.unwrappedLicenseNumber)")
            }
            .frame(maxWidth: 300)
            .padding()
            Spacer()
        }
        .sheet(isPresented: $showEditProfile, content: {
            ProfileEditView(user: user)
        })
        .navigationTitle("Profile")
        .toolbar {
            ToolbarItem {
                Button {
                    showEditProfile.toggle()
                } label: {
                    Text("Edit")
                }

            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ProfileView()
        }.environment(\.managedObjectContext, PersistenceContainer.preview.viewContext)
    }
}
