//
//  CreditsView.swift
//  NoteIt WatchKit Extension
//
//  Created by Abduqodir's MacPro on 2022/07/04.
//

import SwiftUI

struct CreditsView: View {
  //MARK: - Properties
  @State private var randomNumber: Int = Int.random(in: 1..<3)
  private var randomImage: String {
    return "developer-no\(randomNumber)"
  }
  
  //MARK: - Body
  var body: some View {
    VStack(spacing: 3) {
      // Profile Image
      Image(randomImage)
        .resizable()
        .scaledToFit()
        .layoutPriority(1)
      
      // Header
      HeaderView(title: "Credits")
      
      // Content
      Text("Khamzaev Kodirbek")
        .foregroundColor(.primary)
        .fontWeight(.bold)
      
      Text("Developer")
        .font(.footnote)
        .foregroundColor(.secondary)
        .fontWeight(.light)
    } //: VStack
  }
}

//MARK: - Preview
struct CreditsView_Previews: PreviewProvider {
  static var previews: some View {
    CreditsView()
  }
}
