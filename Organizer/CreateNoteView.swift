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
    
    var category: Category
    
    @State private var title: String = ""
    @State private var text: String = ""
        
    var body: some View {
        VStack(spacing: 25.0) {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.white)
                    .shadow(radius: 3)
                    .frame(height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                TextField ("Title", text: $title)
                    .padding(.leading, 3)
            }
            ZStack {
                Rectangle()
                    .fill(Color.white)
                    .shadow(radius: 3)
                TextEditor(text: $text)
                    //.border(Color.gray, width: 1)
            }
            Button(action: {
                    addNote()
                    presentationMode.wrappedValue.dismiss()
            }) {
                Text("Save")
                    .font(.title2)
            }
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 20)
    }
    
    private func addNote() {
        do {
            let newNr = try getNewNr()
            
            let newNote = Note(context: viewContext)
            newNote.title = self.title
            newNote.text = self.text
            newNote.nr = newNr
            
            //try viewContext.save()
            
            category.addToNotes(newNote)
            
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
