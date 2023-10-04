//
//  AddView.swift
//  Multi_Stocks
//
//  Created by Darek Barańczuk on 30/09/2023.
//  Copyright © 2023 orgName. All rights reserved.
//

import SwiftUI
import shared

struct AddView: View {
    @Binding var stock: LocalStock
    
    var body: some View {
        List {
            TextField("Label", text: $stock.label)
                .validate {
                    !stock.label.isEmpty
                }
                .cornerRadius(4)
                .disableAutocorrection(true)
            
            TextField("Param", text: $stock.queryParam)
                .validate {
                    !stock.label.isEmpty
                }
                .disableAutocorrection(true)
                .textInputAutocapitalization(.never)
            
            HStack {
                Text("Param index")
                    .frame(width: 100, alignment: .leading)
                Divider()
                Stepper("\(stock.paramIndex)", value: $stock.paramIndex, in: 0...10)
            }
        }
    }
    
}

struct ValidationPreferenceKey : PreferenceKey {
   static var defaultValue: [Bool] = []

   static func reduce(value: inout [Bool], nextValue: () -> [Bool]) {
      value += nextValue()
   }
}

struct ValidationModifier : ViewModifier  {
   let validation : () -> Bool
   func body(content: Content) -> some View {
         content
            .preference(
               key: ValidationPreferenceKey.self,
               value: [validation()]
            )
      }
   }

extension TextField   {
   func validate(_ flag : @escaping ()-> Bool) -> some View {
      self
         .modifier(ValidationModifier(validation: flag))
   }
}

struct TextFormView<Content : View> : View {
   @State var validationSeeds : [Bool] = []
   @ViewBuilder var content : (( @escaping () -> Bool)) -> Content
   var body: some View {
         content(validate)
         .onPreferenceChange(ValidationPreferenceKey.self) { value in
            validationSeeds = value
         }
   }

   private func validate() -> Bool {
      for seed in validationSeeds {
         if !seed { return false}
      }
      return true
   }
}

#Preview {
    AddView(stock: .constant(.default))
}
