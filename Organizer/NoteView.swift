//
//  NoteView.swift
//  Organizer
//
//  Created by Oleg Andreyev on 2/11/21.
//

import SwiftUI

struct NoteView: View {
    
    @Environment(\.managedObjectContext) private var viewContext

    private var note: Note
    
    @State private var newTitle: String
    @State private var newText: String
   
    init(note: Note) {
        self.note = note
        self._newTitle = State(wrappedValue: note.title!)
        self._newText = State(wrappedValue: note.text!)
    }
    
    var body: some View {
        VStack {
            TextField("Title", text: $newTitle, onEditingChanged: {_ in saveNote()})
            TextField("Text", text: $newText, onEditingChanged: {_ in saveNote()})
        }//.onDisappear(perform: saveNote)
    }
    
    private func saveNote() {
        note.title = newTitle
        note.text = newText
        
        do {
            try viewContext.save()
        } catch {
        
        }
    }
}

/*struct NoteView_Previews: PreviewProvider {
    static var previews: some View {
        NoteView()
    }
}*/
