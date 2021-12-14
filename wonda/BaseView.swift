//
//  BaseView.swift
//  wonda
//
//  Created by mp on 14/12/2021.
//

import SwiftUI

struct BaseView: View {
    var body: some View {
        NavigationView {
            List {
                NavigationLink {
                    TextRecognitionView()
                } label: {
                    Image(systemName: "a.magnify")
                    Text("Text Recognition")
                }
            }
            .navigationTitle("Vision tasks")
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        BaseView()
    }
}
