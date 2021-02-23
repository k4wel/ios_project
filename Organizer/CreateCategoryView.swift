//
//  CreateCategoryView.swift
//  Organizer
//
//  Created by Oleg Andreyev on 2/9/21.
//

import SwiftUI

struct CreateCategoryView: View {
    
    @State private var name: String = ""
    
    @Environment(\.presentationMode) private var presentationMode
    @Environment(\.managedObjectContext) private var viewContext
    
    @Binding var isPresented: Bool
    
    var body: some View {
        VStack(spacing: 25.0) {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.white)
                    .shadow(radius: 3)
                    .frame(height: 40, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                TextField(
                    "Category name",
                    text: $name
                )
                .padding(.leading, 3.0)
            }
            Button(action: {
                saveCategory()
                isPresented = false
            }) {
                Text("Create")
                    .font(.title2)
            }
        }
        .padding(.horizontal, 10)
    }
    
    private func saveCategory() {
        let newCategory = Category(context: viewContext)
        newCategory.id = UUID()
        newCategory.name = self.name
        
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
}

/*struct CreateCategoryView_Previews: PreviewProvider {
    static var previews: some View {
        CreateCategoryView()
    }
}*/
