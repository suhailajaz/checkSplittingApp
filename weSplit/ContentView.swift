//
//  ContentView.swift
//  weSplit
//
//  Created by suhail on 27/04/22.
//

import SwiftUI

struct ContentView : View {
        @State private var checkAmount = 0.0
        @State private var noOfPeople = 2
        @State private var tipPercentage =  20
        //@FocusState private var amountIsFocused: Bool

        @FocusState private var amountIsFocused : Bool
        //@FoucsState is used to check wheter a ui element is in fous or not
        
        // let tipPercentages = [10,15,20,25,30,0]
        
    
    var dollarFormatter : FloatingPointFormatStyle<Double>.Currency {
        let currencyCode = Locale.current.currencyCode ?? "USD"
        return FloatingPointFormatStyle<Double>.Currency(code: currencyCode)
    }
    
    var totalAmount : Double{
        
        let tipSelection = Double(tipPercentage)
        let tipValue = tipSelection/100 * checkAmount
        let grandTotal = checkAmount + tipValue
        
        
        return grandTotal
    }
    
    
    
    var totalPerPerson : Double{
            let peopleCount = Double (noOfPeople+2)
            let tipSelection = Double(tipPercentage)
            let tipValue = tipSelection/100 * checkAmount
            
            let grandTotal = checkAmount + tipValue
            let amountPerPerson = grandTotal/peopleCount
            
            return amountPerPerson
        }
        
        
        
        
        var body: some View {
            NavigationView{
                Form{
                        Section{
                            
                        TextField("Amount", value:$checkAmount, format: dollarFormatter)
                           
                            .keyboardType(.decimalPad)
                            .focused($amountIsFocused)

                            //.focused($amountIsFocused)
                            
                            Picker("No of people: ", selection: $noOfPeople){
                                ForEach(2..<100){
                                    Text("\($0) people")
                                }
                            }
                        } header:{
                            Text("Enter cheque amount:")
                        }
                    
                    Section{
                        Picker("Tip Percentags: ", selection: $tipPercentage){
                            ForEach(0..<100){
                                Text($0, format: .percent)
                            }
                        }
                        //.pickerStyle(.segmented)
                    } header: {
                        Text("How much tip do you want to leave?")
                    }
                    Section{
                        Text(totalAmount, format: dollarFormatter)
                        
                        
                    }header:{
                        Text("Grand Total: ")
                    }
                    
                        Section{
                            Text(totalPerPerson, format: dollarFormatter)
                        } header: {
                            Text("Total per person: ")
                        }
                }
                .navigationTitle("WeSplit")
                .navigationBarTitleDisplayMode(.inline)
                
                 .toolbar{
                    //attaches a done button to the keyboard and pushes it to the left
                    ToolbarItemGroup(placement : .keyboard){
                        Spacer()
                        
                        Button("Done"){
                            amountIsFocused=false
                        }
                    }
                }
            }
        }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
           
        }
    }
}
