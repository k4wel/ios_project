//
//  CreateNoteView.swift
//  Organizer
//
//  Created by Student on 10/02/2021.
//

import SwiftUI
import CoreData

struct CreateNoteView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    var category : Category
    
    @State private var title: String = ""
    @State private var text: String = ""
    
    @Binding var isPresented: Bool;
    
    var body: some View {
        VStack {
            TextField ("Title", text: $title)
            TextField("Text", text: $text)
            Button(action: addNote) {
                Text("Save")
            }
        }
    }
    
    private func addNote() {
        let newNote = Note(context: viewContext)
        newNote.title = self.title
        newNote.text = text
        
        category.addToNotes(newNote)
    }
    
    private func getNewNr() throws -> Int {
        let fetchRequest: NSFetchRequest<AutoIncrement> = AutoIncrement.fetchRequest()
        let records = try fetchRequest.execute()
    }
}

struct CreateNoteView_Previews: PreviewProvider {
    static var previews: some View {
        CreateNoteView()
    }
}
