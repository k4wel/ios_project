//
//  CategoryView.swift
//  Organizer
//
//  Created by Oleg Andreyev on 2/10/21.
//

import SwiftUI
import CoreData

struct CategoryView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) private var presentationMode
    
    @State private var showModal = false
    @State private var trigger = true
    
    var categoryId: UUID;
    
   /* @FetchRequest(
        sortDescriptors: [],
        predicate: NSPredicate(format: "category.id == %@", categoryId.uuidString))
    private var notes: FetchedResults<Note> */
   
    private var category : Category? {
        let fetchRequest = NSFetchRequest<Category>(entityName: "Category")
        fetchRequest.predicate = NSPredicate(format: "id == %@", categoryId.uuidString)
        
        do {
            let categories = try viewContext.fetch(fetchRequest)
            if(categories.count > 0) {
                return categories[0]
            } else {
                presentationMode.wrappedValue.dismiss()
                return nil
            }
        } catch {
            presentationMode.wrappedValue.dismiss()
            return nil
        }
    }
    
    private var notes: [Note] {
        let fetchRequest = NSFetchRequest<Note>(entityName: "Note")
        fetchRequest.predicate = NSPredicate(format: "category.id == %@", categoryId.uuidString)
        
        do {
            let results = try viewContext.fetch(fetchRequest)
            return results
        } catch {
            return []
        }
    }
        
    var body: some View {
        //NavigationView {
            List {
                /*ForEach(nssetToArray(category!.notes!), id: \.nr) { note in
                    Text("\(note.title!)")
                }*/
                ForEach(notes, id: \.nr) { note in
                    Text("\(note.title ?? "huj")")
                }
                .onDelete(perform: deleteNotes)
            }.sheet(isPresented: $showModal) {
                CreateNoteView(category: self.category!, isPresented: $showModal)
            }
            .navigationBarTitle("Notes")
            .toolbar {
                Button(action: addNote) {
                    Label("Add note", systemImage: "plus")
                }
                
            }
      /*  }.sheet(isPresented: $showModal) {
            CreateNoteView(category: self.category!, isPresented: $showModal)
        } */
    }
    
    private func nssetToArray(_ nsset: NSSet) -> [Note] {
        let set = nsset as Set<NSObject>
        return Array(set.map({$0 as! Note}))
    }
    
    private func addNote() {
        showModal.toggle()
    }
    
    private func deleteNotes(offsets: IndexSet) {
        withAnimation {
            //offsets.map { categories[$0] }.forEach(viewContext.delete)
            
            offsets.map{notes[$0]}.forEach(viewContext.delete)
            
            do {
                try viewContext.save()
                trigger.toggle()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
            //trigger.toggle()
        }
    }
}

/*struct CategoryView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryView()
    }
} */
