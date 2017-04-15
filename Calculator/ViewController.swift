//
//  ViewController.swift
//  Calculator
//
//  Created by Hien on 4/15/17.
//  Copyright © 2017 Hien. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
    
    @IBOutlet weak var btn0: UIButton!
    
    @IBOutlet weak var btn1: UIButton!
    
    @IBOutlet weak var btn2: UIButton!
    
    @IBOutlet weak var btn3: UIButton!
    
    @IBOutlet weak var btn4: UIButton!
    
    @IBOutlet weak var btn5: UIButton!

    @IBOutlet weak var btn6: UIButton!
    
    @IBOutlet weak var btn7: UIButton!
    
    @IBOutlet weak var btn8: UIButton!
    
    @IBOutlet weak var btn9: UIButton!
    
    @IBOutlet weak var btnDecimal: UIButton!
    
    @IBOutlet weak var btnEqual: UIButton!
    
    @IBOutlet weak var btnAdd: UIButton!
    
    @IBOutlet weak var btnSub: UIButton!
    
    @IBOutlet weak var btnMul: UIButton!
    
    @IBOutlet weak var btnDiv: UIButton!
    
    @IBOutlet weak var btnClear: UIButton!
    
    @IBOutlet weak var Result: UITextField!
    
    
    @IBAction func btn0_press(_ sender: Any) {
        handleinput(str: "0")
    }
    
    @IBAction func btn1_press(_ sender: Any) {
        handleinput(str: "1")
    }
    
    @IBAction func btn2_press(_ sender: Any) {
        handleinput(str: "2")
    }
    
    @IBAction func btn3_press(_ sender: Any) {
        handleinput(str: "3")
    }
    
    @IBAction func btn4_press(_ sender: Any) {
        handleinput(str: "4")
    }
    
    @IBAction func btn5_press(_ sender: Any) {
        handleinput(str: "5")
    }
    
    @IBAction func btn6_press(_ sender: Any) {
        handleinput(str: "6")
    }
    
    @IBAction func btn7_press(_ sender: Any) {
        handleinput(str: "7")
    }
    
    @IBAction func btn8_press(_ sender: Any) {
        handleinput(str: "8")
    }
    
    @IBAction func btn9_press(_ sender: Any) {
        handleinput(str: "9")
    }
    
    @IBAction func btnDec_press(_ sender: Any) {
        if hashIndes(stringToSearch: input, characterToFind: ".") == false
        {
            handleinput(str: ".")
                    }
    }
    
    @IBAction func btnCle_press(_ sender: Any) {
        input = ""
        accumulator = 0
        Display()
        numStack.removeAll()
        opStack.removeAll()
    }
    
    @IBAction func btnEqu(_ sender: Any) {
        Equal()
    }
    
    @IBAction func btnAdd_press(_ sender: Any) {
        calculate(newOp: "+")
    }
    
    @IBAction func btnSub_press(_ sender: Any) {
        calculate(newOp: "-")    }
    
    @IBAction func btnMul_press(_ sender: Any) {
        calculate(newOp: "*")    }
    
    @IBAction func btnDiv_press(_ sender: Any) {
        calculate(newOp: "/")    }
    
    var accumulator: Double = 0.0
    var input = ""
    var numStack: [Double] = []
    var opStack: [String] = []
    
    func hashIndes(stringToSearch str: String, characterToFind chr: Character) -> Bool
    {
        for c in str.characters{
            if c == chr{
                return true
        }
        }
        return false
    }
    func handleinput(str : String)
    {
        if str == "-"{
            if input.hasPrefix(str)
            {
                input = input.substring(from: input.index(after: input.startIndex))
                
            } else {
                input = str + input
            }
        } else {
            input += str
        }
        accumulator = Double((input as NSString).doubleValue)
        Display()
    }
    func Display()
    {
        var iAcc = Int(accumulator)
        if accumulator - Double(iAcc) == 0
        {
            Result.text = "\(iAcc)"
        }else {
            Result.text = "\(accumulator)"
        }
    }
    func calculate(newOp : String)
    {
        if input != "" && numStack.isEmpty {
            var stackOp = opStack.last
            if !((stackOp == "+" || stackOp == "-") && (newOp == "*" || newOp == "/")){
                var oper = ops[opStack.removeLast()]
                accumulator = oper!(numStack.removeLast(), accumulator)
                Equal()
            }
        }
    }
    func Equal()
    {
        if input == ""{
            return
        }
        if !numStack.isEmpty{
            var oper = ops[opStack.removeLast()]
            accumulator = oper!(numStack.removeLast(), accumulator)
            if !opStack.isEmpty {
                Equal()
            }
        }
        Display()
        input = ""
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
func add(a: Double, b: Double) -> Double
{
    var result = a + b
    return result
}
func sub(a: Double, b: Double) -> Double
{
    var result = a - b
    return result
}
func mul(a: Double, b: Double) -> Double
{
    var result = a * b
    return result
}
func div(a: Double, b: Double) -> Double
{
    var result = a / b
    return result
}
typealias Binop = (Double, Double) -> Double
let ops: [String: Binop] = [ "+" : add, "-" : sub, "*" : mul, "/" : div ]
