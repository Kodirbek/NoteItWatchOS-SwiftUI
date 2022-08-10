//
//  ContentView.swift
//  NoteIt WatchKit Extension
//
//  Created by Abduqodir's MacPro on 2022/07/04.
//

import SwiftUI

struct ContentView: View {
  
  //MARK: - Properties
  
  @State private var notes: [NoteIt] = [NoteIt]()
  @State private var text: String = ""
  @AppStorage("lineCount") var lineCount: Int = 1
  
  //MARK: - Function
  
  func getDocumentDirectory() -> URL {
    let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    return path[0]
  }
  
  func save() {
    // save the note to the database
    do {
      // 1. Convert the notes array to data using JSON Encoder
      let data = try JSONEncoder().encode(notes)
      
      // 2. Create a new URL to save the file using getDocumentDirectory
      let url = getDocumentDirectory().appendingPathComponent("notes")
      
      // 3. Write the data to the given URL
      try data.write(to: url)
      
    } catch {
      print("Saving data failed")
    }
  }
  
  func load() {
    DispatchQueue.main.async {
      do {
        // 1. Get the notes URL path
        let url = getDocumentDirectory().appendingPathComponent("notes")
        
        // 2. Create a new property for the data
        let data = try Data(contentsOf: url)
        
        // 3. Decode the data
        notes = try JSONDecoder().decode([NoteIt].self, from: data)
        
      } catch {
        // Do nothing
      }
    }
  }
  
  func delete(offsets: IndexSet) {
    withAnimation {
      notes.remove(atOffsets: offsets)
      save()
    }
  }
  
  //MARK: - Body
  var body: some View {
    VStack {
      HStack(alignment: .center, spacing: 6) {
        TextField("Add new note", text: $text)
        
        Button {
          // 1. Button runs only when the text field is not empty
          guard text.isEmpty == false else {return}
          
          // 2. Create a new note item and initialize it with the text value
          let note = NoteIt(id: UUID(), text: text)
          
          // 3. Add the new note item to the notes array (append)
          notes.append(note)
          
          // 4. Make the text field empty
          text = ""
          
          // 5. Save the notes (function)
          save()
          
        } label: {
          Image(systemName: "plus.circle")
            .font(.system(size: 42, weight: .semibold))
        }
        .fixedSize()
        .buttonStyle(PlainButtonStyle())
        .foregroundColor(.accentColor)
      } //: HStack
      
      Spacer()
      
      if notes.count >= 1 {
        List {
          ForEach(0..<notes.count, id: \.self) { i in
            NavigationLink(destination: DetailView(note: notes[i], count: notes.count, index: i)) {
              HStack {
                Capsule()
                  .frame(width: 4)
                  .foregroundColor(.accentColor)
                
                Text(notes[i].text)
                  .lineLimit(lineCount)
                  .padding(.leading, 5)
              } //: HStack
            } //: NavLink
          } //: Loop
          .onDelete(perform: delete)
        }
      } else {
        Spacer()
        Image(systemName: "note.text")
          .resizable()
          .scaledToFit()
          .foregroundColor(.accentColor)
          .opacity(0.25)
          .padding(25)
        Spacer()
      } //: List
    } //: VStack
    .navigationTitle("NoteIt")
    .onAppear {
      load()
    }
  }
}

//MARK: - Preview

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
