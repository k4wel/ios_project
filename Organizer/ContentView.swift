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
                ForEach(categories) { category in
                    Text("\(category.name!)")
                }
                .onDelete(perform: deleteCategories)
            }
            .toolbar {
                //EditButton()
                
                Button(action: addCategory) {
                    Label("Add category", systemImage: "plus")
                }.sheet(isPresented: $showModal, content: {
                    CreateCategoryView(isPresented: self.$showModal).environment(\.managedObjectContext, viewContext)
                })
            }
        }
    }

    private func addCategory() {
        showModal.toggle()
    }
    
    private func addItem2() {
        withAnimation {
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date()

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

    private func deleteCategories(offsets: IndexSet) {
        withAnimation {
            offsets.map { categories[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
