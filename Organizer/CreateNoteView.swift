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
    @Environment(\.presentationMode) private var presentationMode
    
    var categoryId : UUID
    
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
    
    @State private var title: String = ""
    @State private var text: String = ""
        
    var body: some View {
        VStack {
            TextField ("Title", text: $title)
            TextField("Text", text: $text)
            Button(action: {
                    addNote()
                    presentationMode.wrappedValue.dismiss()
            }) {
                Text("Save")
            }
        }
    }
    
    private func addNote() {
        do {
            let newNr = try getNewNr()
            
            let newNote = Note(context: viewContext)
            newNote.title = self.title
            newNote.text = self.text
            newNote.nr = newNr
            
            //try viewContext.save()
            
            category!.addToNotes(newNote)
            
            try updateCounter(newNr)
            
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    
    private func getNewNr() throws -> Int32 {
        let fetchRequest: NSFetchRequest<AutoIncrement> = AutoIncrement.fetchRequest()
        let records = try viewContext.fetch(fetchRequest)
        var newNr: Int32;
        
        if (records.count == 0) {
            newNr = 1
        } else {
            newNr = records[0].nr + 1
        }
        return newNr;
    }
    
    private func updateCounter(_ newValue: Int32) throws {
        let fetchRequest: NSFetchRequest<AutoIncrement> = AutoIncrement.fetchRequest()
        let records = try viewContext.fetch(fetchRequest)
        
        records.forEach(viewContext.delete)
        
        let newRecord = AutoIncrement(context: viewContext)
        newRecord.nr = newValue
        
        try viewContext.save()
    }
}

/*struct CreateNoteView_Previews: PreviewProvider {
    static var previews: some View {
        CreateNoteView()
    }
}*/
