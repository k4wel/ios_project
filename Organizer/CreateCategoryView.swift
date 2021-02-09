//
//  CreateCategoryView.swift
//  Organizer
//
//  Created by Oleg Andreyev on 2/9/21.
//

import SwiftUI

struct CreateCategoryView: View {
    
    @State private var name: String = ""
    @State private var isEditing = false
    
    @Environment(\.presentationMode) private var presentationMode
    @Environment(\.managedObjectContext) private var viewContext
    
    @Binding var isPresented: Bool
    
    var body: some View {
        VStack {
            TextField(
                "Category name",
                text: $name
            ) { isEditing in
                self.isEditing = isEditing
            }
            Button(action: {
                
        
                
                let newCategory = Category(context: viewContext)
                newCategory.id = UUID()
                newCategory.name = self.name
                
                do {
                    try viewContext.save()
                    //isPresented.toggle()
                } catch {
                    let nsError = error as NSError
                    fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
                }
                
                isPresented = false
                
                //presentationMode.wrappedValue.dismiss()
            }) {
                Text("Create")
            }
        }
    }
}

/*struct CreateCategoryView_Previews: PreviewProvider {
    static var previews: some View {
        CreateCategoryView()
    }
}*/
