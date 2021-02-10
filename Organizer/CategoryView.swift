//
//  CategoryView.swift
//  Organizer
//
//  Created by Oleg Andreyev on 2/10/21.
//

import SwiftUI

struct CategoryView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    var category : Category
    
    @State private var showModal = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(category.notes, id: \.nr) { note in
                    Text("\(note.title!)")
                }
            }
            .navigationBarTitle("Notes")
            .toolbar {
                Button(action: addNote) {
                    Label("Add note", systemImage: "plus")
                }
                
            }
        }
    }
    
    private func addNote() {
        showModal.toggle()
    }
    
    private func deleteCategories(offsets: IndexSet) {
        withAnimation {
            offsets.map { categories[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }}

struct CategoryView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryView()
    }
}
