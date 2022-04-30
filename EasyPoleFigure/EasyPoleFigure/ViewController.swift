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
    
    @IBOutlet weak var editButton: UIButton!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        let userInputX = millerX
        let userInputY = millerY
        let userInputZ = millerZ
    }

     
//    @IBAction func editButtonClicked(_ sender: UIButton)// -> [SIMD2<Double>] {
//        {
////        resultView.layer.sublayers?.filter{ $0.name == "point"}.forEach{ $0.removeFromSuperlayer() }// 전에것 지우는코드
//
////        let userInputX = Double(millerX.text!)
////        let userInputY = Double(millerY.text!)
////        let userInputZ = Double(millerZ.text!)
//
//
//
//
//
////        let p = SIMD3<Double>(simd_normalize(simd_double3(x: Double(userInputX) ?? 0, y: Double(userInputY) ?? 0, z: Double(userInputZ) ?? 0))) // 사용자 입력값을 정규화하여 저장(x, y, z)
////
////        var pDotH: [SIMD3<Double>] = []
////        var p_prime: [SIMD2<Double>] = []
////
////        for i in cubicData.indices {
////            pDotH.append(dotP(cubicData[i], p))
////        } // 정규화된 값과 cubic symmetry와 내적 [(x', y', z')]
////
////        // 회전을 시켰을 때 Euler Angle 이용하여 [XZX] dot [(x', y', z')] = [(x'', y'', z'')]
////
////        for i in pDotH.indices {
////            p_prime.append(projection(pDotH[i]))
////        } // 내적된 값을 projection하여 저장 [(X, Y)]
////
//////        return p_prime
////
//////        for i in p_prime.indices {
//////            drawPoleFigure(p_prime[i])
//////        } // [(X, Y)] 값들을 좌표계에 그림
//    }
}
