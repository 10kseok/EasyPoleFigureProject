//  ViewController.swift
//  EasyPoleFigure
//
//  Created by 천성원 on 2022/03/30.
//

import UIKit
import simd
import SceneKit

class ViewController: UIViewController, SCNSceneRendererDelegate {
    
    @IBOutlet weak var millerX: UITextField!
    @IBOutlet weak var millerY: UITextField!
    @IBOutlet weak var millerZ: UITextField!
    @IBOutlet weak var rotateX: UISlider!
    @IBOutlet weak var rotateY: UISlider!
    @IBOutlet weak var rotateZ: UISlider!
    @IBOutlet weak var xAngle: UILabel!
    @IBOutlet weak var yAngle: UILabel!
    @IBOutlet weak var zAngle: UILabel!
    
    @IBOutlet weak var editButton: UIButton!
    
    @IBOutlet weak var resultView: UIView!
    @IBOutlet weak var xyzAxisSceneView: SCNView!
    
    var x_0: CGFloat = 0
    var y_0: CGFloat = 0
    var preRXAng: Double = 0.0
    var preRYAng: Double = 0.0
    var preRZAng: Double = 0.0
    
    lazy var sliders = [self.rotateX, self.rotateY, self.rotateZ]
    var boxEulerAngels: SCNVector3 = SCNVector3()
    
    var pole = SIMD3<Double>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        setCenterOfResultView()
        changeAngleValue()
        drawMainCircle()
        configureSceneView()
        view.addGestureRecognizer(tap)
    }
    
    @objc func handleTap() {
        millerX.resignFirstResponder()
        millerY.resignFirstResponder()
        millerZ.resignFirstResponder()
    }
    
    fileprivate func setCenterOfResultView() {
//        x_0 = resultView.bounds.size.width / 2
//        y_0 = resultView.bounds.size.height / 2
//        x_0 = resultView.bounds.midX
//        y_0 = resultView.bounds.midY // 좀 더 서브뷰에서 중앙에 가까운듯
        x_0 = view.bounds.size.width / 2 - 21
        y_0 = x_0
        
    }
    
    fileprivate func configureSceneView() {
        let scene = configureScene()
        
        xyzAxisSceneView.autoenablesDefaultLighting = true
        xyzAxisSceneView.allowsCameraControl = true
        xyzAxisSceneView.scene = scene
    }
    
    func configureScene() -> SCNScene {
        let scene = SCNScene()
        let boxNode = makeBoxNode()
        let cameraNode = makeCameraNode()
        let axisNode = makeAxisVector()
        
        scene.rootNode.addChildNode(boxNode)
        scene.rootNode.addChildNode(cameraNode)
        
        _ = axisNode.map { boxNode.addChildNode($0) }
        
        return scene
    }
    
    func makeBoxNode() -> SCNNode {
        let box = SCNBox(width: 0.5, height: 0.5, length: 0.5, chamferRadius: 0)
        let boxNode = SCNNode(geometry: box)
        // 카메라로부터 거리조절
        boxNode.position = SCNVector3(0, 0, -2)
        boxNode.geometry?.firstMaterial?.diffuse.contents = UIColor.systemGray2
        
        return boxNode
    }
    
    func makeAxisVector() -> [SCNNode] {
        let xAxis = SCNBox(width: 1, height: 0.05, length: 0.05, chamferRadius: 0)
        let yAxis = SCNBox(width: 0.05, height: 1, length: 0.05, chamferRadius: 0)
        let zAxis = SCNBox(width: 0.05, height: 0.05, length: 1, chamferRadius: 0)
        
//        let xAxis = SCNPlane(width: 0.7, height: 0.1)
        let xAxisNode = SCNNode(geometry: xAxis)
        let yAxisNode = SCNNode(geometry: yAxis)
        let zAxisNode = SCNNode(geometry: zAxis)
        
        xAxisNode.position = SCNVector3(0, 0, 0)
        yAxisNode.position = SCNVector3(0, 0, 0)
        zAxisNode.position = SCNVector3(0, 0, 0)
        
        xAxisNode.geometry?.firstMaterial?.diffuse.contents = UIColor.systemRed
        yAxisNode.geometry?.firstMaterial?.diffuse.contents = UIColor.systemGreen
        zAxisNode.geometry?.firstMaterial?.diffuse.contents = UIColor.systemBlue
        
        return [xAxisNode, yAxisNode, zAxisNode]
    }
    
    func makeCameraNode() -> SCNNode {
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        cameraNode.position = SCNVector3(x: 0, y: 0, z: 0.5)
        
        return cameraNode
    }
    
    func updateSlider(to eulerAngles: SCNVector3) {
        let (boxEulerAnglesX, boxEulerAnglesY, boxEulerAnglesZ) = (eulerAngles.x, eulerAngles.y, eulerAngles.z)
        
        let XDegree = convertRadianToDegree(boxEulerAnglesX)
        let YDegree = convertRadianToDegree(boxEulerAnglesY)
        let ZDegree = convertRadianToDegree(boxEulerAnglesZ)
        
        DispatchQueue.main.async {
            self.rotateX.value = XDegree
            self.rotateY.value = YDegree
            self.rotateZ.value = ZDegree
        }
    }
    
    fileprivate func removePreviousPoint() {
        resultView.layer.sublayers?.filter{ $0.name == "point"}.forEach{ $0.removeFromSuperlayer() }
    }
    
    func updateBoxNode() {
        // [] When Slider Changed, BoxNode's pointOfView has to change!
        
    }
    
 // MARK: 기준원 그리기
    fileprivate func drawMainCircle() {
        let mainCirclePath = UIBezierPath(arcCenter: CGPoint(x: x_0, y: y_0), radius: CGFloat(110), startAngle: CGFloat(0), endAngle: CGFloat(Double.pi * 2), clockwise: true) //CGPoint(x,y)의 위치가 원의 중심입니다.
        let shapeLayerMainCircle = CAShapeLayer()
        
        shapeLayerMainCircle.path = mainCirclePath.cgPath
        shapeLayerMainCircle.fillColor = UIColor.clear.cgColor //change the fill color
        shapeLayerMainCircle.strokeColor = UIColor.red.cgColor //you can change the stroke color
        shapeLayerMainCircle.lineWidth = 1.0 //you can change the line width
        resultView.layer.addSublayer(shapeLayerMainCircle)
    }
    
// MARK: 극점 찍기
    fileprivate func drawPoleFigure(_ p_prime: SIMD2<Double>) {
        let poleFigure = UIBezierPath(arcCenter: CGPoint(x: x_0+110*p_prime[0], y: y_0+110*p_prime[1]), radius: CGFloat(1), startAngle: CGFloat(0), endAngle: CGFloat(Double.pi * 2), clockwise: true)
        let shapeLayerPoleFigure = CAShapeLayer()
        shapeLayerPoleFigure.name = "point"
        shapeLayerPoleFigure.path = poleFigure.cgPath
        shapeLayerPoleFigure.fillColor = UIColor.clear.cgColor //change the fill color
        shapeLayerPoleFigure.strokeColor = UIColor.blue.cgColor //you can change the stroke color
        shapeLayerPoleFigure.lineWidth = 2.0 //you can change the line width
        
        resultView.layer.addSublayer(shapeLayerPoleFigure)
    }
    
// MARK: 버튼 클릭시 극점 생성(기본)
    fileprivate func getSymmetry(_ p: SIMD3<Double>) -> [SIMD3<Double>]{
        // 정규화된 값과 cubic symmetry와 내적 [(x', y', z')]
        var pDotH: [SIMD3<Double>] = []
        for i in cubicData.indices {
            pDotH.append(dotP(cubicData[i], p))
        }
        
        return pDotH
    }
    
    fileprivate func getProjectedPole(_ symmetric_poles: [SIMD3<Double>]) -> [SIMD2<Double>] {
        // 내적된 값을 projection하여 저장 [(X, Y)], 원 내부에 있는것만 저장
        var p_prime = [SIMD2<Double>]()
        for i in symmetric_poles.indices {
            let projection = projection(symmetric_poles[i])
            if sqrt(pow(projection[0], 2) + pow(projection[1], 2)) <= 1 {
                p_prime.append(projection)
            }
        }
        
        return p_prime
    }
    
    
    @IBAction func editButtonClicked(_ sender: UIButton) {
        removePreviousPoint() // 이전에 있던것 지우기
        let userInput = [millerX.text!, millerY.text!, millerZ.text!].map { Double($0) ?? 0 }
        let normalizedUserInput = simd_normalize(simd_double3(userInput)) // 사용자 입력값을 정규화하여 저장(x, y, z)
        pole = normalizedUserInput // 정규화한 값 = 극점
        let symmetric_poles = getSymmetry(pole) // 극점들의 대칭들을 구함
        let p_prime = getProjectedPole(symmetric_poles) // Polefigure을 나타내기위해 평면에 투영시킨 점들을 구함
        
        // 평면에 투영시킨 값들을 좌표계에 그림
        for i in p_prime.indices {
            drawPoleFigure(p_prime[i])
        }
        handleTap()
    }
    
// MARK: 회전관련 함수
    @IBAction func rotatingAngle(_ sender: UISlider) {
        let rXAng = Double(round(rotateX.value))
        let rYAng = Double(round(rotateY.value))
        let rZAng = Double(round(rotateZ.value))
        
        // MARK: 회전한 축을 기준으로 돌리지 않고 처음 찍힌 점에서 회전을 시킴
        // 1. 회전시킨 점을 변화된 각으로 회전시킨다.
        // 2. 점을 원내부만 저장시키지말고 전부다 저장시켜서 조건에 맞는것만 보여주는 식으로
        //      2.1 원내부만 저장시키면 회전 시켰을때 점의 갯수가 달라질 수 있다.
        //      2.2 따라서 회전시킨 점들을 다 저장하고 그리는 것만 조건에 맞는 것으로 그린다.
        
        // 입력값
        let radianX = convertDegreeToRadian(rXAng)
        let radianY = convertDegreeToRadian(rYAng)
        let radianZ = convertDegreeToRadian(rZAng)
        print(radianX, radianY, radianZ)
        let XYZ = calcEulerAngle(radianX, radianY, radianZ) // 회전된 값
        let p = SIMD3<Double>(simd_normalize(simd_double3(x: Double(millerX.text!) ?? 0, y: Double(millerY.text!) ?? 0, z: Double(millerZ.text!) ?? 0))) // 사용자 입력값을 정규화하여 저장(x, y, z)
    
        var pDotH: [SIMD3<Double>] = []
        var rotatedPdotH: [SIMD3<Double>] = []
        var p_prime: [SIMD2<Double>] = []
        
        changeAngleValue()
        
        resultView.layer.sublayers?.filter{ $0.name == "point"}.forEach{ $0.removeFromSuperlayer() } // 이전에 있던것 지우기
        
        // p와 H를 내적하여 저장 [x', ]
        for i in cubicData.indices {
            pDotH.append(dotP(cubicData[i], p))
        }
        
        // pDotH를 회전시켜 저장 [rotatedPdotH]
        for i in pDotH.indices {
            rotatedPdotH.append(dotP(XYZ, pDotH[i]))
        }
        
        // 내적된 값을 projection하여 저장 [(X, Y)], 원 내부에 있는것만 저장
        for i in rotatedPdotH.indices {
            let projection = projection(rotatedPdotH[i])
            if sqrt(pow(projection[0], 2) + pow(projection[1], 2)) <= 1 {
                p_prime.append(projection)
            }
        }
        
        // [(X, Y)] 값들을 좌표계에 그림
        for i in p_prime.indices {
            drawPoleFigure(p_prime[i])
        }
    
        // MARK: Box 회전
        if let boxNode = xyzAxisSceneView.scene?.rootNode.childNodes[0] {
            // 쿼터니언 = angle : 회전할 각도, axis : 회전시킬 기준벡터
            // 슬라이더 값을 정수값으로 받고 중복된 값
            switch sender {
            case rotateX:
                // x축 회전
                if preRXAng != rXAng {
                    
                    let rotateXAngle = Int(rXAng-preRXAng)
                    let rotateXQuaternion = simd_quatf(angle: convertDegreeToRadian(Float(rotateXAngle)),
                                                       axis: simd_float3(x: 1,
                                                                         y: 0,
                                                                         z: 0))
                    
                    boxNode.simdLocalRotate(by: rotateXQuaternion)
                    
                    preRXAng = rXAng
                }
                
            case rotateY:
                // y축 회전
                if preRYAng != rYAng {
                    
                    let rotateYAngle = Int(rYAng-preRYAng)
                    let rotateYQuaternion = simd_quatf(angle: convertDegreeToRadian(Float(rotateYAngle)),
                                                       axis: simd_float3(x: 0,
                                                                         y: 1,
                                                                         z: 0))
                    
                    boxNode.simdLocalRotate(by: rotateYQuaternion)
                    
                    preRYAng = rYAng
                }
                
            case rotateZ:
                // x축 회전
                if preRZAng != rZAng {
                    
                    let rotateZAngle = Int(rZAng-preRZAng)
                    let rotateZQuaternion = simd_quatf(angle: convertDegreeToRadian(Float(rotateZAngle)),
                                                       axis: simd_float3(x: 0,
                                                                         y: 0,
                                                                         z: 1))
                    
                    boxNode.simdLocalRotate(by: rotateZQuaternion)

                    preRZAng = rZAng
                }
                print("rotateZ")
                
            default:
                print("Something wrong,,,")
            }
        }
    }

    
    func changeAngleValue() {
        self.xAngle.text = "X axis : \(Int(round(rotateX.value)))"
        self.yAngle.text = "Y axis : \(Int(round(rotateY.value)))"
        self.zAngle.text = "Z axis : \(Int(round(rotateZ.value)))"
    }
}
