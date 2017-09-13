//
//  ViewController.swift
//  Calculadora
//
//  Created by Alan Casas on 21/8/17.
//  Copyright © 2017 Alan Casas. All rights reserved.
//

import UIKit

enum CalculationOperation: String {
    case add = "op-suma"
    case substract = "op-resta"
    case multiply = "op-multiplica"
    case divide = "op-divide"
}

class ViewController: UIViewController {
    
    @IBOutlet weak var icoSuma: UIImageView!
    @IBOutlet weak var icoResta: UIImageView!
    @IBOutlet weak var icoMultiplica: UIImageView!
    @IBOutlet weak var icoDivision: UIImageView!
    
    @IBOutlet weak var labelResult: UILabel!
    
    let currencyFormatter = NumberFormatter()
    var result:String? {
        didSet{
            if let result = result {
                labelResult.text = currencyFormatter.string(from: NSNumber(value: Double(result.replacingOccurrences(of: ",", with: "."))!))
            }
        }
    }
    
    var previusResult : String?
    
    var currentOperation: CalculationOperation?{
        willSet{
            resetIcons()
        }
        didSet{
            if let currentOperation = currentOperation{
                switch currentOperation {
                case .add:
                    icoSuma.image = UIImage(named: "\(CalculationOperation.add.rawValue)-on")
                case .substract:
                    icoSuma.image = UIImage(named: "\(CalculationOperation.substract.rawValue)-on")
                case .multiply:
                    icoSuma.image = UIImage(named: "\(CalculationOperation.multiply.rawValue)-on")
                case .divide:
                    icoSuma.image = UIImage(named: "\(CalculationOperation.divide.rawValue)-on")
                    
                }
            }else{
                resetIcons()
            }
        }
    }
    
    var previousOperation: CalculationOperation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        resetCalculator()
        
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.maximumFractionDigits = 6
        currencyFormatter.numberStyle = .decimal
        currencyFormatter.locale = Locale.current
        
        
        
    }
    
    override var prefersStatusBarHidden: Bool{
        return true
    }
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        
        let key = sender.titleLabel!.text!
        switch key {
        case "1","2","3","4","5","6","7","8","9","0":
            
            if var newResult = result{
                newResult.append(key)
                result = newResult
            }else{
                result = key
            }
            
            break
            
        case ",":
            if var newResult = result{
                if newResult.range(of: ",") == nil{
                    newResult.append(",")
                    result = newResult
                }
            }
            
            break
            
        case "+":
            currentOperation = .add
            applyOperation()
            break
            
        case "-":
            currentOperation = .substract
            applyOperation()
            break
            
        case "×":
            currentOperation = .multiply
            applyOperation()
            break
        case "÷":
            currentOperation = .divide
            applyOperation()
            break
            
        case "±":
            
            if var newResult = result, let currentValue = Double(newResult){
                newResult = String(-currentValue)
            }
            
            
            break
            
            
            
        case "=":
            applyOperation()
            currentOperation = nil
            previousOperation = nil
            previusResult = nil
            break
            
            
        case "AC":
            resetCalculator()
            
        case"%":
            if var newResult = result, let currentValue = Double(newResult){
                newResult = String(currentValue / 100)
                result = newResult
            }
            
            break
            
        default:
            print("Se ha pulsado una opcion inexistente")
            break
            
        }
        
    }
    
    func applyOperation(){
        
        if result != nil{
            
            if var newResult = result,
                let prevOper = previousOperation,
                let preResult = previusResult,
                let doblePrevResult = Double(preResult),
                let dobleResult = Double(newResult){
                
                switch prevOper {
                case .add:
                    newResult = String(doblePrevResult + dobleResult)
                    
                    
                case .substract:
                    newResult = String(doblePrevResult + dobleResult)
                    
                case .multiply:
                    newResult = String(doblePrevResult + dobleResult)
                    
                case .divide:
                    if dobleResult != 0{
                        newResult = String(doblePrevResult + dobleResult)
                    }else{
                        newResult = "El resultado de dividir un numero entre 0 es infinito"
                    }
                    
                }
                
                result = newResult
                previusResult = nil
                previousOperation = nil
                
            }else{
                previousOperation = currentOperation
                previusResult = result
                result = nil
            }
            
        }
        
    }
    
    func resetIcons(){
        
        icoSuma.image = UIImage(named: CalculationOperation.add.rawValue)
        icoResta.image = UIImage(named: CalculationOperation.substract.rawValue)
        icoMultiplica.image = UIImage(named: CalculationOperation.multiply.rawValue)
        icoDivision.image = UIImage(named: CalculationOperation.divide.rawValue)
        
    }
    
    func resetCalculator(){
        resetIcons()
        result = nil
        previusResult = nil
        currentOperation = nil
        previousOperation = nil
        labelResult.text = "0"
    }
    
    
}





























