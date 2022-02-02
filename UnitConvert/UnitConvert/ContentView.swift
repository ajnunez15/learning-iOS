//
//  ContentView.swift
//  UnitConvert
//
//  Created by Andy Nunez on 1/7/22.
//

import SwiftUI

struct ContentView: View {
    @State private var unitAmount: Double = 0.0
    @State private var from: Int = 0
    @State private var to: Int = 1
    @State private var conversionType: String = "Temperature"
    @State private var conversionTypes: [String] = ["Temperature", "Length", "Volume"]
    @FocusState private var amountIsFocused: Bool
    
    private let temperatures = ["C", "F", "K"]
    private let lengths = ["m", "km", "ft"]
    private let volumes = ["mL", "L", "cups"]
    
    
    var convertTemperature: Double {
        var celsiusBase: Double
        switch from {
        case 1:
            celsiusBase = Measurement(value: unitAmount, unit: UnitTemperature.fahrenheit).converted(to: UnitTemperature.celsius).value
        case 2:
            celsiusBase = Measurement(value: unitAmount, unit: UnitTemperature.kelvin).converted(to: UnitTemperature.celsius).value
        default:
            celsiusBase = Measurement(value: unitAmount, unit: UnitTemperature.celsius).converted(to: UnitTemperature.celsius).value
        }
    
        switch to {
        case 1:
            return Measurement(value: celsiusBase, unit: UnitTemperature.celsius).converted(to: UnitTemperature.fahrenheit).value
        case 2:
            return Measurement(value: celsiusBase, unit: UnitTemperature.celsius).converted(to: UnitTemperature.kelvin).value
        default:
            return celsiusBase
        }
    }
    
    var convertLength: Double {
        var metersBase: Double
        switch from {
        case 1:
            metersBase = Measurement(value: unitAmount, unit: UnitLength.kilometers).converted(to: UnitLength.meters).value
        case 2:
            metersBase = Measurement(value: unitAmount, unit: UnitLength.feet).converted(to: UnitLength.meters).value
//        case 3:
//            metersBase = Measurement(value: unitAmount, unit: UnitLength.yards).converted(to: UnitLength.meters).value
//        case 4:
//            metersBase = Measurement(value: unitAmount, unit: UnitLength.miles).converted(to: UnitLength.meters).value
        default:
            metersBase = Measurement(value: unitAmount, unit: UnitLength.meters).converted(to: UnitLength.meters).value
        }
        
        switch to {
        case 1:
            return Measurement(value: metersBase, unit: UnitLength.meters).converted(to: UnitLength.kilometers).value
        case 2:
            return Measurement(value: metersBase, unit: UnitLength.meters).converted(to: UnitLength.feet).value
//        case 3:
//            return Measurement(value: metersBase, unit: UnitLength.meters).converted(to: UnitLength.yards).value
//        case 4:
//            return Measurement(value: metersBase, unit: UnitLength.meters).converted(to: UnitLength.miles).value
        default:
            return metersBase

        }
    }
    
    var convertVolume: Double {
        var millilitersBase: Double
        switch from {
        case 1:
            millilitersBase = Measurement(value: unitAmount, unit: UnitVolume.liters).converted(to: .milliliters).value
        case 2:
            millilitersBase = Measurement(value: unitAmount, unit: UnitVolume.cups).converted(to: .milliliters).value
        default:
            millilitersBase = Measurement(value: unitAmount, unit: UnitVolume.milliliters).converted(to: .milliliters).value
        }
        
        switch to {
        case 1:
            return Measurement(value: millilitersBase, unit: UnitVolume.milliliters).converted(to: .liters).value
        case 2:
            return Measurement(value: millilitersBase, unit: UnitVolume.milliliters).converted(to: .cups).value
        default:
            return millilitersBase
        }
    }
    
    var fromToList: [String] {
        switch conversionType {
        case "Length":
            return lengths
        case "Volume":
            return volumes
        default:
            return temperatures
        }
    }
    
    var fromToConvert: Double {
        switch conversionType {
        case "Length":
            return convertLength
        case "Volume":
            return convertVolume
        default:
            return convertTemperature
        }
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount to convert", value: $unitAmount, format: .number)
                        .keyboardType(.decimalPad)
                        .multilineTextAlignment(.center)
                        .focused($amountIsFocused)
                    
                    Picker("Conversion Type", selection: $conversionType) {
                        ForEach(conversionTypes, id: \.self) {
                            Text($0)
                        }
                    }
                }
                
                Section {
                    Picker("From", selection: $from) {
                        ForEach(0..<fromToList.count) {
                            Text(fromToList[$0])
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("From")
                }
                
                Section {
                    Picker("To", selection: $to) {
                        ForEach(0..<fromToList.count) {
                            Text(fromToList[$0])
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("To")
                }
                
                Section {
                    HStack {
                        Spacer()
                        Text(fromToConvert, format: .number)
                        Text(fromToList[to])
                        Spacer()
                    }
                }
                .font(Font.title.bold())
                
            }
            .navigationTitle("Conversion 🛠")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
