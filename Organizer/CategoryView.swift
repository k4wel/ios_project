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
    
    @State private var showModal = false
       
    var categoryId: UUID
    var category: Category
    
    @State private var test: String = ""
               
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Note.nr, ascending: true)])
    private var allNotes: FetchedResults<Note>
    
    private var notes: [Note] {
        return allNotes.filter({$0.category?.id == categoryId})
    }
    
    var body: some View {
        List {
            ForEach(notes, id: \.nr) { note in
                NavigationLink(destination: NoteView(note: note)) {
                    Text("\(note.title!)")
                }
            }
            .onDelete(perform: deleteNotes)
        }
        .sheet(isPresented: $showModal) {
            CreateNoteView(category: category)
        }
        .navigationBarTitle(category.name!)
        .toolbar {
            Button(action: addNote) {
                Label("Add note", systemImage: "plus")
            }
        }
    }
    
    private func addNote() {
        showModal.toggle()
    }
    
    private func deleteNotes(offsets: IndexSet) {
        withAnimation {
            offsets.map{notes[$0]}.forEach(viewContext.delete)
            
            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

/*struct CategoryView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryView()
    }
} */
