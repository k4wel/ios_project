//
//  NoteView.swift
//  Organizer
//
//  Created by Oleg Andreyev on 2/11/21.
//

import SwiftUI

struct NoteView: View {
    
    @Binding var note: Note
    
    var body: some View {
        VStack {
            TextField("Title", text: $(note.title))
            TextField("Text", text: $(note.text))
        }
    }
}

/*struct NoteView_Previews: PreviewProvider {
    static var previews: some View {
        NoteView()
    }
}*/
