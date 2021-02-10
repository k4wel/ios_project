//
//  ContentView.swift
//  Organizer
//
//  Created by Student on 07/02/2021.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [],
        animation: .default)
    private var categories: FetchedResults<Category>
    
    @State private var showModal = false

    var body: some View {
        NavigationView {
          //  .navigationBarTitle("")
            List {
                ForEach(categories, id: \.id) { category in
                    Text("\(category.name!)")
                }
                .onDelete(perform: deleteCategories)
            }
            .navigationBarTitle("Categories")
            .toolbar {
                //EditButton()
                
                Button(action: addCategory) {
                    Label("Add category", systemImage: "plus")
                }
                
            }
        }.sheet(isPresented: $showModal) {             CreateCategoryView(isPresented: self.$showModal)

        }
    }

    private func addCategory() {
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
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
