//
//  ProfileEditView.swift
//  flight-log-ios
//
//  Created by Johannes Scribante on 2022/12/30.
//

import SwiftUI

struct ProfileEditView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.managedObjectContext) private var moc
    
    var user: User
    
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var email: String = ""
    @State private var licenseNumber: String = ""
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("First name", text: $firstName)
                TextField("Last name", text: $lastName)
                TextField("Email", text: $email)
                TextField("License number", text: $licenseNumber)
            }
            .navigationTitle("Edit Profile")
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Text("Cancel")
                    }
                    
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        save()
                    } label: {
                        Text("Save")
                    }
                    
                }
            })
        }
        .onAppear{
            firstName = user.unwrappedFirstName
            lastName = user.unwrappedLastName
            email = user.unwrappedEmail
            licenseNumber = user.unwrappedLicenseNumber
        }
    }
    
    func save() {
        user.firstName = firstName
        user.lastName = lastName
        user.email = email
        user.licenseNumber = licenseNumber
        
        do {
            if moc.hasChanges {
                print("save")
                try moc.save()
            }
            dismiss()
        } catch {
            print(error.localizedDescription)
        }
    }
}

struct ProfileEditView_Previews: PreviewProvider {
    static var previews: some View {
        let viewContext = PersistenceContainer.preview.viewContext
        
        let user = User(context: viewContext)
        user.id = 1
        user.uuid = UUID()
        user.firstName = "Oliver"
        user.lastName = "Wright"
        user.email = "oliver.wright@wingit.co"
        user.licenseNumber = "XYZ1001ABC9876"
        
        return NavigationStack {
            ProfileEditView(user: user)
        }
        .environment(\.managedObjectContext, PersistenceContainer.preview.viewContext)
    }
}
