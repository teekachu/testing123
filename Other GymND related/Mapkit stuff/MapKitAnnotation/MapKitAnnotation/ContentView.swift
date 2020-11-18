//
//  ContentView.swift
//  MapKitAnnotation
//
//  Created by Tee Becker on 11/17/20.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ///(1)
        MapView()
            .edgesIgnoringSafeArea(.all)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
