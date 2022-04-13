//
//  ViewController.swift
//  EasyPoleFigure
//
//  Created by 천성원 on 2022/03/30.
//

import UIKit

func projection(_ pole: [Double]) -> [Double] {
    let p_prime = [pole[0]/(1-pole[2]), pole[1]/(1-pole[2])]
    
    return p_prime
    
}

class ViewController: UIViewController {
    
    @IBOutlet weak var millerX: UITextField!
    
    @IBOutlet weak var millerY: UITextField!
    
    @IBOutlet weak var millerZ: UITextField!
    
    @IBOutlet weak var makeButton: UIButton!
    
    var x_0: CGFloat = 0
    var y_0: CGFloat = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        x_0 = view.center.x
        y_0 = view.center.y
        
        drawCircle()
        // Do any additional setup after loading the view.
    }

    fileprivate func drawCircle() {
        
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: x_0, y: y_0), radius: CGFloat(100), startAngle: CGFloat(0), endAngle: CGFloat(Double.pi * 2), clockwise: true) //CGPoint(x,y)의 위치가 원의 중심입니다.
        let shapeLayer1 = CAShapeLayer()
        shapeLayer1.path = circlePath.cgPath
        shapeLayer1.fillColor = UIColor.clear.cgColor //change the fill color
        shapeLayer1.strokeColor = UIColor.red.cgColor //you can change the stroke color
        shapeLayer1.lineWidth = 1.0 //you can change the line width
        view.layer.addSublayer(shapeLayer1)
    }
    
    fileprivate func drawPoint(_ p_prime: [Double]) {
        let dotPath = UIBezierPath(arcCenter: CGPoint(x: x_0+100*p_prime[0], y: y_0+100*p_prime[1]), radius: CGFloat(1), startAngle: CGFloat(0), endAngle: CGFloat(Double.pi * 2), clockwise: true)
        let shapeLayer2 = CAShapeLayer()
        shapeLayer2.path = dotPath.cgPath
        shapeLayer2.fillColor = UIColor.clear.cgColor //change the fill color
        shapeLayer2.strokeColor = UIColor.blue.cgColor //you can change the stroke color
        shapeLayer2.lineWidth = 2.0 //you can change the line width
        view.layer.addSublayer(shapeLayer2)
        
    }

}



extension ViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        let userInputX = millerX.text!
        let userInputY = millerY.text!
        let userInputZ = millerZ.text!
        let p_prime = projection([Double(userInputX) ?? 0, Double(userInputY) ?? 0, Double(userInputZ) ?? 0])
        drawPoint(p_prime)
    }
    // 이게 버튼을 눌렀을 때 실행되도록 바꿔야함
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

}
