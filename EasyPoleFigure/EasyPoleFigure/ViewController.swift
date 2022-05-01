//
//  ViewController.swift
//  EasyPoleFigure
//
//  Created by 천성원 on 2022/03/30.
//

import UIKit
import simd


class ViewController: UIViewController {
    
    @IBOutlet weak var millerX: UITextField!
    @IBOutlet weak var millerY: UITextField!
    @IBOutlet weak var millerZ: UITextField!
    @IBOutlet weak var rotateX: UISlider!
    @IBOutlet weak var rotateY: UISlider!
    @IBOutlet weak var rotateZ: UISlider!
    
    @IBOutlet weak var editButton: UIButton!
    
    @IBOutlet weak var resultView: UIView!
    
    var x_0: CGFloat = 0
    var y_0: CGFloat = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        x_0 = resultView.bounds.size.width / 2
        y_0 = resultView.bounds.size.height / 2
//        x_0 = resultView.bounds.midX
//        y_0 = resultView.bounds.midY // 좀 더 서브뷰에서 중앙에 가까운듯
//        x_0 = resultView.center.x
//        y_0 = resultView.center.y
        
        drawMainCircle()
    }

 // MARK: 기준원 그리기
    fileprivate func drawMainCircle() {
        
        let mainCirclePath = UIBezierPath(arcCenter: CGPoint(x: x_0, y: y_0), radius: CGFloat(150), startAngle: CGFloat(0), endAngle: CGFloat(Double.pi * 2), clockwise: true) //CGPoint(x,y)의 위치가 원의 중심입니다.
        let shapeLayerMainCircle = CAShapeLayer()
        
        shapeLayerMainCircle.path = mainCirclePath.cgPath
        shapeLayerMainCircle.fillColor = UIColor.clear.cgColor //change the fill color
        shapeLayerMainCircle.strokeColor = UIColor.red.cgColor //you can change the stroke color
        shapeLayerMainCircle.lineWidth = 1.0 //you can change the line width
        resultView.layer.addSublayer(shapeLayerMainCircle)
        
    }
    
// MARK: 극점 찍기
    fileprivate func drawPoleFigure(_ p_prime: SIMD2<Double>) {
        let poleFigure = UIBezierPath(arcCenter: CGPoint(x: x_0+150*p_prime[0], y: y_0+150*p_prime[1]), radius: CGFloat(1), startAngle: CGFloat(0), endAngle: CGFloat(Double.pi * 2), clockwise: true)
        let shapeLayerPoleFigure = CAShapeLayer()
        shapeLayerPoleFigure.name = "point"
        shapeLayerPoleFigure.path = poleFigure.cgPath
        shapeLayerPoleFigure.fillColor = UIColor.clear.cgColor //change the fill color
        shapeLayerPoleFigure.strokeColor = UIColor.blue.cgColor //you can change the stroke color
        shapeLayerPoleFigure.lineWidth = 2.0 //you can change the line width
        resultView.layer.addSublayer(shapeLayerPoleFigure)
    }
    
// MARK: 버튼 클릭시 극점 생성(기본)
    @IBAction func editButtonClicked(_ sender: UIButton) {
        resultView.layer.sublayers?.filter{ $0.name == "point"}.forEach{ $0.removeFromSuperlayer() } // 이전에 있던것 지우기
        
        let userInputX = millerX.text!
        let userInputY = millerY.text!
        let userInputZ = millerZ.text!
        let p = SIMD3<Double>(simd_normalize(simd_double3(x: Double(userInputX) ?? 0, y: Double(userInputY) ?? 0, z: Double(userInputZ) ?? 0))) // 사용자 입력값을 정규화하여 저장(x, y, z)
        var pDotH: [SIMD3<Double>] = []
        var p_prime: [SIMD2<Double>] = []
        
        for i in cubicData.indices {
            pDotH.append(dotP(cubicData[i], p))
        } // 정규화된 값과 cubic symmetry와 내적 [(x', y', z')]
        
//        for i in pDotH.indices {
//            p_prime.append(projection(pDotH[i]))
//        } // 내적된 값을 projection하여 저장 [(X, Y)]
        
        for i in pDotH.indices {
            let projection = projection(pDotH[i])
            if sqrt(pow(projection[0], 2) + pow(projection[1], 2)) <= 1 {
                p_prime.append(projection)
            }
        } // 내적된 값을 projection하여 저장 [(X, Y)], 원 내부에 있는것만 저장
        
        for i in p_prime.indices {
            drawPoleFigure(p_prime[i])
            print("p_prime\(i) = \(p_prime[i])")
        } // [(X, Y)] 값들을 좌표계에 그림
    }
    
// MARK: 회전관련 함수
    @IBAction func rotatingXAngle(_ sender: Any) {
        let pi = Double.pi
        let radian = pi/180.0
        let radianX = Double(rotateX.value) * radian
        let radianY = Double(rotateY.value) * radian
        let radianZ = Double(rotateZ.value) * radian

        let userInputX = millerX.text!
        let userInputY = millerY.text!
        let userInputZ = millerZ.text!
        let p = SIMD3<Double>(simd_normalize(simd_double3(x: Double(userInputX) ?? 0, y: Double(userInputY) ?? 0, z: Double(userInputZ) ?? 0))) // 사용자 입력값을 정규화하여 저장(x, y, z)
        
        var rotatedP: [SIMD3<Double>] = []
        var pDotH: [SIMD3<Double>] = []
        var p_prime: [SIMD2<Double>] = []
        
        let rotatedXYZ = calcEulerAngle(radianX, radianY, radianZ)
        
        resultView.layer.sublayers?.filter{ $0.name == "point"}.forEach{ $0.removeFromSuperlayer() } // 이전에 있던것 지우기
        
        for i in rotatedXYZ {
            rotatedP.append(dot(p, rotatedXYZ[i]))
        } // 정규화된 값과 회전시킨 값 내적시키기
        
        for i in cubicData.indices {
            pDotH.append(dotP(cubicData[i], p))
        } // 정규화된 값과 cubic symmetry와 내적 [(x', y', z')]
        
        let rotatedXYZ = calcEulerAngle(radianX, radianY, radianZ) // 회전된 3x3행렬 하나 나옴
        
        // 회전을 시켰을 때 Euler Angle 이용하여 XYZ dot pDotH[(x', y', z')] = [(x", y", z")]
        
        for i in p_prime.indices {
            drawPoleFigure(p_prime[i])
            print("p_prime\(i) = \(p_prime[i])")
        } // [(X, Y)] 값들을 좌표계에 그림
    }
    
    
    @IBAction func rotatingYAngle(_ sender: Any) {
        
    }
    
    
    @IBAction func rotatingZAngle(_ sender: Any) {
    }
}
