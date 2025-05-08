import SwiftUI

struct BoatView: View {
    var boatItems: [Item]
    
    var body: some View {
        HStack{
            ForEach(boatItems, id: \.self) { item in
                Image(item.rawValue) 
                    .resizable()
                    //.scaledToFit()
                    .frame(width: 30, height: 80)
            }
        }
    }
}
