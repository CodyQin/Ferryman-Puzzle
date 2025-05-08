import SwiftUI

enum Item: String, CaseIterable {
    case wolf = "wolf"
    case sheep = "sheep"
    case cabbage = "cabbage"
    case wolfEat = "wolf eat"
    case sheepDead = "sheep dead"
    case sheepEat = "sheep eat"
    
    
}


struct ContentView: View {
    
    @State var button: [Item] = [.wolf, .sheep, .cabbage]
    @State var leftBank: [Item] = [.wolf, .sheep, .cabbage]
    @State var rightBank: [Item] = []
    @State var leftBank2: [Item] = [.wolfEat, .sheepDead]
    @State var rightBank2: [Item] = [.wolfEat, .sheepDead]
    @State var leftBank3: [Item] = [.sheepEat, .cabbage]
    @State var rightBank3: [Item] = [.sheepEat, .cabbage]
    @State var boat: [Item] = []
    @State var position: CGFloat = -80
    @State var isGameOver: Bool = false
    
    @State private var isShowingPopUp = true
    @State private var answer = false
    
    var body: some View {
        ZStack{
            Image("background").resizable().scaledToFill().frame(maxWidth:.greatestFiniteMagnitude, maxHeight: .infinity).edgesIgnoringSafeArea(.all)
            
            Button (action:{isShowingPopUp.toggle()}){
                Image("info").resizable().frame(width: 100, height: 100).scaledToFit()
            }.offset(x:600,y:-400).disabled(isShowingPopUp || (leftBank.contains(.wolf) && position == 80 && leftBank.contains(.sheep))||(rightBank.contains(.wolf) && position == -80 && rightBank.contains(.sheep)))
            
            Button (action:{answer.toggle()}){
                Image("answer").resizable().frame(width: 100, height: 150).scaledToFit()
            }.offset(x:600,y:-270).disabled(isShowingPopUp || (leftBank.contains(.wolf) && position == 80 && leftBank.contains(.sheep))||(rightBank.contains(.wolf) && position == -80 && rightBank.contains(.sheep)))
            
            Button (action:reset){
                Image("reset").resizable().frame(width: 100, height: 100).scaledToFit()
            }.offset(x:600,y:-150).disabled(isShowingPopUp || (leftBank.contains(.wolf) && position == 80 && leftBank.contains(.sheep))||(rightBank.contains(.wolf) && position == -80 && rightBank.contains(.sheep)))
            
            VStack {
                if (answer){
                    Image("board")
                        .resizable()
                        .frame(width: 1000, height: 306)
                        .overlay(
                            VStack {
                                Text("Instruction")
                                    .font(.custom("Comic Sans MS", size: 30))
                                    .foregroundColor(.black)
                                    .shadow(color: .gray, radius: 2, x: 1, y: 1)
                                //.padding()
                                Text("1. Take the goat over     2. Return to other side\n3. Take the wolf or cabbage over     4. Return with the goat\n5. Take the cabbage or wolf over     6. Return\n7. Take goat over")
                                    .font(.custom("Comic Sans MS", size: 20))
                                    .foregroundColor(.black)
                                    .shadow(color: .gray, radius: 2, x: 1, y: 1)
                                //.padding()
                            }).offset(x:0,y:70)
                }else {
                    VStack{
                        Text("Can you move all three items to the right bank?")
                            .font(.custom("Comic Sans MS", size: 40))
                            .foregroundColor(.white)
                            .overlay(
                                Text("Can you move all three items to the right bank?")
                                    .font(.custom("Comic Sans MS", size: 40))
                                    .foregroundColor(.black)
                                
                            )
                            .shadow(color: .gray, radius: 2, x: 1, y: 1)
                            .padding(.top, 150)
                        Text("You can't leave the wolf and the sheep alone on one side or the sheep and the cabbage alone on one side")
                            .font(.custom("Comic Sans MS", size: 20))
                            .foregroundColor(.white)
                            .overlay(
                                Text("You can't leave the wolf and the sheep alone on one side or the sheep and the cabbage alone on one side")
                                    .font(.custom("Comic Sans MS", size: 20))
                                    .foregroundColor(.black)
                                
                            )
                            .shadow(color: .gray, radius: 2, x: 1, y: 1)
                            .padding(.top, 30)
                    }.background(Image("title").resizable().scaledToFit().scaleEffect(1.2).offset(y:70))
                }
                
                Group{
                    HStack {
                        if (leftBank.contains(.wolf) && position == 80 && leftBank.contains(.sheep)){
                            BankView(bankItems: leftBank2).offset(x:-300,y:100)
                                //.padding(.top, 200).padding(.trailing,200).padding(.leading,50)
                        }else if (leftBank.contains(.sheep) && position == 80 && leftBank.contains(.cabbage)){
                            BankView(bankItems: leftBank3).offset(x:-300,y:100)
                                //.padding(.top, 200).padding(.trailing,200).padding(.leading,50)
                        }else{
                            BankView(bankItems: leftBank).offset(x:-300,y:100)
                                //.padding(.top, 200).padding(.trailing,200).padding(.leading,50)
                        }
                        if boat.contains(.cabbage){
                            Image("boat with cabbage")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 300, height: 150)
                                .offset(x: position,y:80)
                                .animation(.spring(response: 1, dampingFraction: 0.6, blendDuration: 1),value: position)
                        }else if boat.contains(.sheep){
                            Image("boat with sheep")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 300, height: 150)
                                .offset(x: position,y:80)
                                .animation(.spring(response: 1, dampingFraction: 0.6, blendDuration: 1),value: position)
                        }else if boat.contains(.wolf){
                            Image("boat with wolf")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 300, height: 150)
                                .offset(x: position,y:80)
                                .animation(.spring(response: 1, dampingFraction: 0.6, blendDuration: 1),value: position)
                        }else{
                            Image("boat")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 300, height: 150)
                                .offset(x: position,y:80)
                                .animation(.spring(response: 1, dampingFraction: 0.6, blendDuration: 1),value: position)
                        }
                        if (rightBank.contains(.wolf) && position == -80 && rightBank.contains(.sheep)){
                            BankView(bankItems: rightBank2).offset(x:300,y:100)
                                //.padding(.top, 200).padding(.trailing,200).padding(.leading,50)
                        }else if (rightBank.contains(.sheep) && position == -80 && rightBank.contains(.cabbage)){
                            BankView(bankItems: rightBank3).offset(x:300,y:100)
                                //.padding(.top, 200).padding(.trailing,200).padding(.leading,50)
                        }else{
                            BankView(bankItems: rightBank).offset(x:300,y:100)
                            //.padding(.trailing,200).padding(.leading,50)
                        }
                    }.padding(.bottom, 30)
                    
                }
                
                    if !(leftBank.isEmpty && rightBank.contains(.sheep)){
                        HStack {
                            ForEach(button, id: \.self) { item in
                                Button(action: {
                                    moveItem(item: item)
                                }) {
                                    Text("Move \(item.rawValue)")
                                        .frame(width: 130, height: 30)
                                        .font(.headline)
                                        .foregroundColor(.white)
                                        .padding()
                                        .background(Color.blue)
                                        .cornerRadius(10)
                                }.disabled((leftBank.isEmpty && rightBank.contains(.sheep)) || (!boat.isEmpty && boat[0] != item)||(leftBank.contains(item) && position == 80)||(rightBank.contains(item) && position == -80)||(leftBank.contains(.wolf) && position == 80 && leftBank.contains(.sheep))||(rightBank.contains(.wolf) && position == -80 && rightBank.contains(.sheep))||(leftBank.contains(.sheep) && position == 80 && leftBank.contains(.cabbage))||(rightBank.contains(.sheep) && position == -80 && rightBank.contains(.cabbage)))
                                    .buttonStyle(.plain).offset(y:200).padding()
                                
                            }
                        }
                        Button(action: {
                            moveBoat()
                        },label: {
                            Text("Move Boat").font(.title3)
                                .frame(width: 200, height: 50)
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.blue)
                                .cornerRadius(10)
                        }).disabled((leftBank.isEmpty && rightBank.contains(.sheep))||(leftBank.isEmpty && boat.isEmpty&&(position == 80))||(rightBank.isEmpty && boat.isEmpty && (position == -80))||(leftBank.contains(.wolf) && position == 80 && leftBank.contains(.sheep))||(rightBank.contains(.wolf) && position == -80 && rightBank.contains(.sheep))||(leftBank.contains(.sheep) && position == 80 && leftBank.contains(.cabbage))||(rightBank.contains(.sheep) && position == -80 && rightBank.contains(.cabbage))).padding()
                            .buttonStyle(.plain).offset(y:220)
                        
                        
                        Spacer()
                    
                    }
            }
            
            if isShowingPopUp {
                
                Image("board")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 1300, height: 800)
                    .overlay(
                        VStack {
                            Text("Ferryman Puzzle")
                                .font(.custom("Comic Sans MS", size: 40))
                                .foregroundColor(.black)
                                .shadow(color: .gray, radius: 2, x: 1, y: 1)
                                .padding()
                            Text("The Ferryman Puzzle (wolf, goat and cabbage problem) is a river crossing puzzle. \nIt dates back to at least the 9th century, and has entered the folklore of several cultures.")
                                .font(.custom("Comic Sans MS", size: 17))
                                .foregroundColor(.black)
                                .shadow(color: .gray, radius: 2, x: 1, y: 1)
                                .padding(.leading, 44)
                            Text("The Story")
                                .font(.custom("Comic Sans MS", size: 30))
                                .foregroundColor(.black)
                                .shadow(color: .gray, radius: 2, x: 1, y: 1)
                                .padding()
                            Text("A ferryman bought a wolf, a goat, and a cabbage from the market. \nHe rented a boat to cross a river, but the boat could only carry him and one of the three items at a time. \nIf the wolf and the goat or the goat and the cabbage were left alone together, one would be eaten. \nThe ferryman had to figure out how to get all three items across the river without any of them being eaten.")
                                .font(.custom("Comic Sans MS", size: 15))
                                .foregroundColor(.black)
                                .shadow(color: .gray, radius: 2, x: 1, y: 1)
                                .padding(.leading, 44)
                            Button("Let's Help Him") {
                                // Toggle the state to hide the pop-up
                                isShowingPopUp.toggle()
                            }.font(.title3)
                                .frame(width: 150, height:20)
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.indigo)
                                .cornerRadius(10)
                        }
                    )
                
            }
            
            if leftBank.isEmpty && rightBank.contains(.sheep) {
                
                Image("board")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 1300, height: 800)
                    .overlay(
                        VStack(alignment: .center) {
                            Text("Congratulations!")
                                .font(.custom("Comic Sans MS", size: 30))
                                .foregroundColor(.red)
                                .shadow(color: .gray, radius: 2, x: 1, y: 1)
                                .padding()
                            Text("You have successfully crossed the river with all items!!")
                                .font(.custom("Comic Sans MS", size: 28))
                                .foregroundColor(.red)
                                .shadow(color: .gray, radius: 2, x: 1, y: 1)
                                .padding()
                            Button (action:reset){
                                Image("reset").resizable().frame(width: 100, height: 100).scaledToFit().padding()
                            }
                        })
            }
            
            if (leftBank.contains(.wolf) && position == 80 && leftBank.contains(.sheep))||(rightBank.contains(.wolf) && position == -80 && rightBank.contains(.sheep)) {
                
                Image("board")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 1200, height: 500)
                    .overlay(
                        VStack(alignment: .center) {
                            Text("GAME OVER~")
                                .font(.custom("Comic Sans MS", size: 30))
                                .foregroundColor(.red)
                                .shadow(color: .gray, radius: 2, x: 1, y: 1)
                                .padding()
                            Text("The wolf will eat the sheep!")
                                .font(.custom("Comic Sans MS", size: 28))
                                .foregroundColor(.red)
                                .shadow(color: .gray, radius: 2, x: 1, y: 1)
                                .padding()
                            Button (action:reset){
                                Image("reset").resizable().frame(width: 100, height: 100).scaledToFit().padding()
                            }
                        }).offset(y:-260)
            }
            
            if (leftBank.contains(.sheep) && position == 80 && leftBank.contains(.cabbage))||(rightBank.contains(.sheep) && position == -80 && rightBank.contains(.cabbage)) {
                
                Image("board")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 1200, height: 500)
                    .overlay(
                        VStack(alignment: .center) {
                            Text("GAME OVER~")
                                .font(.custom("Comic Sans MS", size: 30))
                                .foregroundColor(.red)
                                .shadow(color: .gray, radius: 2, x: 1, y: 1)
                                .padding()
                            Text("The sheep will eat the cabbage!")
                                .font(.custom("Comic Sans MS", size: 28))
                                .foregroundColor(.red)
                                .shadow(color: .gray, radius: 2, x: 1, y: 1)
                                .padding()
                            Button (action:reset){
                                Image("reset").resizable().frame(width: 100, height: 100).scaledToFit().padding()
                            }
                        }).offset(y:-260)
            }
        }
    }
    
    func reset(){
        boat.removeAll()
        leftBank.removeAll()
        rightBank.removeAll()
        leftBank.append(Item.wolf)
        leftBank.append(Item.sheep)
        leftBank.append(Item.cabbage)
        position = -80
        
    }
    
    
    func moveItem(item: Item) {
        if boat.contains(item) {
            boat.removeAll(where: {$0 == item})
            if position == 80 {
                rightBank.append(item)
            } else {
                leftBank.append(item)
            }
        }else{ 
                if position == -80 {
                    if leftBank.contains(item) {
                        leftBank.removeAll(where: {$0 == item})
                        boat.append(item)
                    } 
                }else{
                    if rightBank.contains(item) {
                        rightBank.removeAll(where: {$0 == item})
                        boat.append(item)
                    }
                }
            }
    }
    
    func moveBoat() {
        if position == 80 {
            //leftBank += boat
            position = -80
        } else {
            //rightBank += boat
            position = 80
        }

    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

