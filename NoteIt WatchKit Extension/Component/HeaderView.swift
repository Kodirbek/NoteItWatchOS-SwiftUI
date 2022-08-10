//
//  HeaderView.swift
//  NoteIt WatchKit Extension
//
//  Created by Abduqodir's MacPro on 2022/07/04.
//

import SwiftUI

struct HeaderView: View {
  
  var title: String = ""
  
  var body: some View {
    // Header
    VStack {
      //Title
      if title != "" {
        Text(title.uppercased())
          .font(.title3)
          .fontWeight(.bold)
          .foregroundColor(.accentColor)
      }
      
      //Separator
      HStack {
        Capsule()
          .frame(height: 1)
        Image(systemName: "note.text")
        Capsule()
          .frame(height: 1)
      }
      .foregroundColor(.accentColor)
    } //: VStack
    
  }
}

struct HeaderView_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      HeaderView(title: "Credits")
      
      HeaderView()
    }
  }
}
