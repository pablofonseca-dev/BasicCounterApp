//
//  ContentView.swift
//  CounterApp
//
//  Created by Pablo Fonseca Mata on 24/8/23.
//

import SwiftUI

struct ContentView: View {
    enum Field {
        case counter
    }
    @FocusState private var focusedField: Field?
    
    @State private var counter = "0";
    
    var body: some View {
        ZStack{
            Color(UIColor(hex: "#176CA8") ?? .clear).ignoresSafeArea()
            VStack{
                VStack(spacing:50){
                    HStack(alignment: .center){
                        TextField("", text: $counter, onEditingChanged: { editing in
                                if !editing {
                                    handleOnValueChange(newValue: counter)
                                }
                            })
                            .focused($focusedField, equals: .counter)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .keyboardType(.numberPad)
                            .multilineTextAlignment(.center)
                            .font(.system(size: 40))
                    }.frame(maxWidth: .infinity)
                    VStack(spacing:30){
                        HStack(alignment: .center) {
                            Button(action: {count(positive: false)}){
                                Text("-")
                                    .frame(
                                        maxWidth: 80,
                                        maxHeight: 50
                                    )
                                    .font(.system(size: 30, weight: .bold))
                            }
                            .buttonStyle(.bordered)
                            .tint(.pink)
                            Spacer()
                            Button(action: {count(positive: true)}){
                                Text("+")
                                    .frame(
                                        maxWidth: 80,
                                        maxHeight: 50
                                    )
                                    .font(.system(size: 30, weight: .bold))
                            }
                            .buttonStyle(.borderedProminent)
                            .tint(.pink)
                        }
                        VStack(alignment: .center){
                            Button(action: {
                                resetCount()
                            }){
                                Text(Image(systemName: "trash.circle.fill"))
                                    .frame(
                                        maxHeight: 40
                                    )
                                    .font(.system(size:30))
                                    .frame(maxWidth: .infinity)
                            }
                            .buttonStyle(.bordered)
                        }
                    }
                }
                .frame(maxWidth: 300)
                .padding(30)
                .background(.white)
                .cornerRadius(20)
            }
        }
        .onTapGesture {
            hideKeyboard()
        }
    }
    
    
    func count(positive: Bool = false){
        counter = positive ? "\((Int(counter) ?? 0) + 1)" : "\((Int(counter) ?? 0) - 1)";
    }
    
    func resetCount(){
        counter = "0";
    }
    
    func handleOnValueChange(newValue: String){
        print("Entered");
        counter = newValue;
    }
}


#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
