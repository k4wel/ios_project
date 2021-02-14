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
        ScrollView {
            VStack(spacing: 25.0) {
                ZStack {
                    RoundedRectangle(cornerRadius: 10.0)
                        .fill(Color.white)
                        .shadow(radius: 3)
                        .frame(height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    TextField("Title", text: $newTitle, onEditingChanged: {_ in saveNote()})
                        .padding(.leading, 5)
                }
                ZStack {
                    Rectangle()
                        .fill(Color.white)
                        .shadow(radius: 3)
                    TextEditor(text: $newText)
                        .lineLimit(nil)
                }
            }
            .padding(.horizontal, 10)
            .padding(.top, 10)
        }
        .onDisappear(perform: saveNote)
        .navigationTitle("#\(note.nr)")
    }
    
    private func saveNote() {
        note.title = newTitle
        note.text = newText
        
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
}

struct NoteView_Previews: PreviewProvider {
    static var previews: some View {
        NoteView(note: Note())
    }
}
