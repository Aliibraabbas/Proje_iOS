
import SwiftUI

struct CalculatorView: View {
    @State private var display = "0"
    @State private var firstNumber = 0.0
    @State private var currentOperation: String? = nil
    
    var body: some View {
        VStack {
            Spacer()
            Text(display)
                .font(.largeTitle)
                .padding()
                .frame(maxWidth: .infinity, alignment: .trailing)
                .background(Color.gray.opacity(0.2))
            
            Spacer()

            let buttons = [
                ["7", "8", "9", "+"],
                ["4", "5", "6", "-"],
                ["1", "2", "3", "*"],
                ["0", "C", "=", "/"]
            ]
            
            ForEach(buttons, id: \.self) { row in
                HStack {
                    ForEach(row, id: \.self) { button in
                        Button(action: {
                            self.buttonTapped(button)
                        }) {
                            Text(button)
                                .font(.largeTitle)
                                .frame(width: 70, height: 70)
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(35)
                                .padding(5)
                        }
                    }
                }
            }
        }
        .padding()
    }

    func buttonTapped(_ button: String) {
        switch button {
        case "C":
            display = "0"
            firstNumber = 0.0
            currentOperation = nil
        case "=":
            if let operation = currentOperation {
                let secondNumber = Double(display) ?? 0
                if operation == "+" {
                    display = String(firstNumber + secondNumber)
                } else if operation == "-" {
                    display = String(firstNumber - secondNumber)
                } else if operation == "*" {
                    display = String(firstNumber * secondNumber)
                } else if operation == "/" {
                    display = secondNumber != 0 ? String(firstNumber / secondNumber) : "Error"
                }
                currentOperation = nil
            }
        case "+", "-", "*", "/":
            firstNumber = Double(display) ?? 0
            currentOperation = button
            display = "0"
        default:
            if display == "0" {
                display = button
            } else {
                display += button
            }
        }
    }
}

struct CalculatorView_Previews: PreviewProvider {
    static var previews: some View {
        CalculatorView()
    }
}
