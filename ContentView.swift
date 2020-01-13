//
//  ContentView.swift
//  Calculator
//
//  Created by Mobolaji Moronfolu on 1/8/20.
//  Copyright © 2020 Mobolaji Moronfolu. All rights reserved.
//

import SwiftUI


enum CalculatorButton : String{
    
    case zero , one, two, three, four, five, six, seven, eight, nine
    case equals, plus, minus, multiply, divide
    case ac, plusminus, percent, dot
    
    var title: String {
        switch self{
        case .zero: return "0"
        case .one:
            return "1"
        case .two:
            return "2"
        case .three:
            return "3"
        case .four:
            return "4"
        case .five:
            return "5"
        case .six:
            return "6"
        case .seven:
            return "7"
        case .eight:
            return "8"
        case .nine:
            return "9"
        case .equals:
            return "="
        case .plus:
            return "+"
        case .minus:
            return "-"
        case .multiply:
            return "X"
        case .divide:
            return "/"
        case .plusminus:
            return "+/-"
        case .percent:
            return "%"
        case .dot:
            return "."
        default: return "AC"
        }
    }
    var background: Color{
        switch self {
        case .zero:
            return Color(.darkGray)
        case .ac:
            return Color(.lightGray)
        case .one:
             return Color(.darkGray)
        case .two:
             return Color(.darkGray)
        case .three:
             return Color(.darkGray)
        case .four:
             return Color(.darkGray)
        case .five:
             return Color(.darkGray)
        case .six:
             return Color(.darkGray)
        case .equals:
            return Color(red: 225 / 255, green: 215 / 255, blue: 0/255)
        case .plus:
            return Color(red: 225 / 255, green: 215 / 255, blue: 0/255)
        case .minus:
            return Color(red: 225 / 255, green: 215 / 255, blue: 0/255)
        case .multiply:
           return Color(red: 225 / 255, green: 215 / 255, blue: 0/255)
        case .divide:
            return Color(red: 225 / 255, green: 215 / 255, blue: 0/255)
        case .plusminus:
            return Color(.lightGray)
        case .percent:
            return Color(red: 225 / 255, green: 215 / 255, blue: 0/255)
        case .seven:
            return Color(.darkGray)
        case .eight:
            return Color(.darkGray)
        case .nine:
            return Color(.darkGray)
        default:
        return Color(.blue)
        }
    }
    
}

class GlobalEnvironment: ObservableObject{
    @Published var display = "start calculating"
    var firstNumber:String = ""
    var secondNumber: String = ""
    var operation: Int = 0
    var reset: Bool = false
    func receiveInput(calculatorButton: CalculatorButton){
        
        let operators: [String :Int ] = ["%" :0 , "/" : 1, "-" : 2, "+" : 3,"AC" : 4, "X" :5, "=" :6]
        reset = false
        if operators[calculatorButton.title] != nil{
                if calculatorButton.title == "%"{
                    operation = 0
                    self.display = ""
                    firstNumber = secondNumber
                } else if calculatorButton.title == "/"{
                    operation = 1
                    self.display = ""
                    firstNumber = secondNumber
                }else if calculatorButton.title == "-"{
                    operation = 2
                    self.display = ""
                    firstNumber = secondNumber
                }else if calculatorButton.title == "+"{
                operation = 3
                self.display = ""
                firstNumber = secondNumber
                secondNumber = ""
                }else if calculatorButton.title == "X"{
                    operation = 4
                    self.display = ""
                    firstNumber = secondNumber
                }
                else if calculatorButton.title == "="{
                    self.display = ""
                    reset = true
                    switch operation{
                    case 0:
                        secondNumber =  String((Float( secondNumber) ?? 0) / 100)
                    case 1:
                        secondNumber = String((Int( secondNumber) ?? 0) / (Int(firstNumber) ?? 0))
                    case 2:
                        secondNumber = String((Int( secondNumber) ?? 0) - (Int(firstNumber) ?? 0))
                    case 3:
                        secondNumber = String((Float( secondNumber) ?? 0) + (Float(firstNumber) ?? 0))
                    case 4:
                       secondNumber = String((Int( secondNumber) ?? 0) * (Int(firstNumber) ?? 0))
                    default:
                        self.display = " "
                    }
                }
                else{
                    firstNumber = ""
                    secondNumber = ""
                    self.display = ""
                }
        } else{
            secondNumber = secondNumber + calculatorButton.title
            self.display = secondNumber
        }
        self.display = secondNumber
        if reset == true{
            secondNumber = ""
        }
          
        }
    }

struct ContentView: View {
    
    @EnvironmentObject var env: GlobalEnvironment
    
    let buttons : [[CalculatorButton]] = [
    [.ac, .plusminus, .percent, .divide],
    [.seven, .eight, .nine, .multiply],
    [.four, .five, .six, .minus],
    [.one, .two, .three, .plus],
    [.zero, .dot, .equals],
    
    ]
    var body: some View {
        ZStack (alignment: .bottom){
            Color.black.edgesIgnoringSafeArea(.all)
            VStack(spacing :12) {
                
                HStack{
                    Spacer()
                    Text(env.display).foregroundColor(.white)
                        .font(.system(size:64))
                    
                }.padding()
                
                      ForEach(buttons, id: \.self) { row in
                        HStack(spacing :12){
                              ForEach(row, id: \.self){ button in
                                CalculatorButtonView(button:button)
                                
                      }
                      
                          }
                          
                      }
                      
            }.padding(.bottom)
        }
      
    }
    
    
struct CalculatorButtonView: View{
    var button: CalculatorButton
    @EnvironmentObject var env :GlobalEnvironment
    
    var body: some View{
        Button(action: {
            self.env.receiveInput(calculatorButton: self.button)
        }){
                Text(button.title)
                .font(.system(size :32))
                  .frame(width: self.buttonWidth(button:button), height: self.buttonHeight(button:button))
                  .foregroundColor(.white)
                  .background(button.background)
                  .cornerRadius(self.buttonWidth(button: button))
        }
        
    }
    private func buttonWidth(button: CalculatorButton) -> CGFloat{
            if button == .zero{
                return (UIScreen.main.bounds.width - 5 * 12)/2
            }
            return (UIScreen.main.bounds.width - 5 * 12)/4
        }
    private func buttonHeight(button: CalculatorButton) -> CGFloat{
           return (UIScreen.main.bounds.width - 5 * 12)/4
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(GlobalEnvironment())
    }
}
