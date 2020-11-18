//
//  LoadingView.swift
//  LottieView
//
//  Created by Tee Becker on 11/6/20.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        VStack{
            LottieView(fileName: "gym")
                .frame(width: 200, height: 200, alignment: .center)
        }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
