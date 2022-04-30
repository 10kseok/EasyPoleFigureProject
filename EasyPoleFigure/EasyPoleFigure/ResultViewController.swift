//
//  ResultViewController.swift
//  EasyPoleFigure
//
//  Created by 천성원 on 2022/04/29.
//

import UIKit
import simd


class ResultViewController: ViewController {
    @IBOutlet weak var resultView: UIView!
    
    @IBOutlet weak var sliderX: UISlider!
    @IBOutlet weak var sliderY: UISlider!
    @IBOutlet weak var sliderZ: UISlider!
    
    var x_0: CGFloat = 0
    var y_0: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 원 그리는 위치 정하기
        x_0 = resultView.bounds.size.width / 2
        y_0 = resultView.bounds.size.height / 2
//        print(resultView.bounds.midX, resultView.bounds.midY)
//        print(resultView.center.x, resultView.center.y)
        
        // 유저 입력 저장, ViewController 값 받아오기!!!!!!!!!!!!1
//        let userInputX = millerX.text!
//        let userInputY = ViewController.millerY.text!
//        let userInputZ = ViewController.millerZ.text!
        
        // 임시값
        let userInputX = 1.0
        let userInputY = 1.0
        let userInputZ = -1.0
        
        // 사용자 입력값을 정규화하여 저장(x, y, z)
//        let p = SIMD3<Double>(simd_normalize(simd_double3(x: Double(userInputX) ?? 0, y: Double(userInputY) ?? 0, z: Double(userInputZ) ?? 0)))
        
        // 임시값
        let p = SIMD3<Double>(simd_normalize(simd_double3(x: userInputX, y: userInputY, z: userInputZ)))
        var pDotH: [SIMD3<Double>] = []
        var p_prime: [SIMD2<Double>] = []
        
        // 정규화된 값과 cubic symmetry와 내적 [(x', y', z')]
        for i in cubicData.indices {
            pDotH.append(dotP(cubicData[i], p))
        }
        
        // 회전을 시켰을 때 Euler Angle 이용하여 [XZX] dot [(x', y', z')] = [(x'', y'', z'')]
        
        // 내적된 값을 projection하여 저장 [(X, Y)]
        for i in pDotH.indices {
            p_prime.append(projection(pDotH[i]))
        }

        // 뷰에 점 초기화
        resultView.layer.sublayers?.filter{ $0.name == "point"}.forEach{ $0.removeFromSuperlayer() }
        
        // 원 그리기
        drawMainCircle()
        
        // 원에 점 찍기, [(X, Y)] 값들을 좌표계에 그림
        for i in p_prime.indices {
            drawPoleFigure(p_prime[i])
        }
    }
    
// 함수목록
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
        shapeLayerPoleFigure.name = "point"
        shapeLayerPoleFigure.path = poleFigure.cgPath
        shapeLayerPoleFigure.fillColor = UIColor.clear.cgColor //change the fill color
        shapeLayerPoleFigure.strokeColor = UIColor.blue.cgColor //you can change the stroke color
        shapeLayerPoleFigure.lineWidth = 2.0 //you can change the line width
        resultView.layer.addSublayer(shapeLayerPoleFigure)
    }
}
