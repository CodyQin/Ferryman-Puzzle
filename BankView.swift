import SwiftUI

struct BankView: View {
    var bankItems: [Item]
    
    var body: some View {
        HStack{
            ForEach(bankItems, id: \.self) { item in
                Image(item.rawValue) 
                    .resizable()
                    //.scaledToFit()
                    .frame(width: 130, height: 130)
            }
        }
    }
}
