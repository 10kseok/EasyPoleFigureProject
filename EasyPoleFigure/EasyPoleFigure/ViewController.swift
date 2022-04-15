//
//  ViewController.swift
//  EasyPoleFigure
//
//  Created by 천성원 on 2022/03/30.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var millerX: UITextField!
    @IBOutlet weak var millerY: UITextField!
    @IBOutlet weak var millerZ: UITextField!
    
    @IBOutlet weak var editButton: UIButton!
    
    @IBOutlet weak var resultView: UIView!
    
    var x_0: CGFloat = 0
    var y_0: CGFloat = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        x_0 = resultView.bounds.midX
        y_0 = resultView.bounds.midY // 좀 더 서브뷰에서 중앙에 가까운듯
//        x_0 = resultView.center.x
//        y_0 = resultView.center.y
        
        drawMainCircle()
        // Do any additional setup after loading the view.
    }

    fileprivate func drawMainCircle() {
        
        let mainCirclePath = UIBezierPath(arcCenter: CGPoint(x: x_0, y: y_0), radius: CGFloat(100), startAngle: CGFloat(0), endAngle: CGFloat(Double.pi * 2), clockwise: true) //CGPoint(x,y)의 위치가 원의 중심입니다.
        let shapeLayerMainCircle = CAShapeLayer()
        
        shapeLayerMainCircle.path = mainCirclePath.cgPath
        shapeLayerMainCircle.fillColor = UIColor.clear.cgColor //change the fill color
        shapeLayerMainCircle.strokeColor = UIColor.red.cgColor //you can change the stroke color
        shapeLayerMainCircle.lineWidth = 1.0 //you can change the line width
        resultView.layer.addSublayer(shapeLayerMainCircle)
    }
    
    fileprivate func drawPoleFigure(_ p_prime: SIMD2<Double>) {
        let poleFigure = UIBezierPath(arcCenter: CGPoint(x: x_0+100*p_prime[0], y: y_0+100*p_prime[1]), radius: CGFloat(1), startAngle: CGFloat(0), endAngle: CGFloat(Double.pi * 2), clockwise: true)
        let shapeLayerPoleFigure = CAShapeLayer()
        
        shapeLayerPoleFigure.path = poleFigure.cgPath
        shapeLayerPoleFigure.fillColor = UIColor.clear.cgColor //change the fill color
        shapeLayerPoleFigure.strokeColor = UIColor.blue.cgColor //you can change the stroke color
        shapeLayerPoleFigure.lineWidth = 2.0 //you can change the line width
        resultView.layer.addSublayer(shapeLayerPoleFigure)
        
    }
    
    @IBAction func editButtonClicked(_ sender: UIButton) {
        let userInputX = millerX.text!
        let userInputY = millerY.text!
        let userInputZ = millerZ.text!
        let p_prime = projection([Double(userInputX) ?? 0, Double(userInputY) ?? 0, Double(userInputZ) ?? 0])
        drawPoleFigure(p_prime)
    }
}
