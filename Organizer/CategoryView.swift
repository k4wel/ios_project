//
//  CategoryView.swift
//  Organizer
//
//  Created by Oleg Andreyev on 2/10/21.
//

import SwiftUI

struct CategoryView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    var category : Category
    
    var body: some View {
        NavigationView {
            List {
                ForEach(category.notes, id: \.nr) { note in
                    Text("\(note.title!)")
                }
            }
            .navigationBarTitle("Notes")
            .toolbar {
                Button(action: addNote) {
                    Label("Add note", systemImage: "plus")
                }
                
            }
        }
    }
    
    private func addNote() {
        
    }
}

struct CategoryView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryView()
    }
}
