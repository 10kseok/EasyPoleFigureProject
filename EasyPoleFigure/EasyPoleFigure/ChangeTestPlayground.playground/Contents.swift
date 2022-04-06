import UIKit
import Matft


var str =  "1 0 0"



var arr = str.components(separatedBy: " ")

print(arr)


//func projection(_ pole: [Double]) -> [Double] {
//    let p_prime = [pole[0]/(1-pole[2]), pole[0]/(1-pole[2])]
//
//    return p_prime
//
//}
//projection([sqrt(3)/3, sqrt(3)/3, sqrt(3)/3])
//
//
//             func makeM() -> [Double] {
//
//}

let circlePath = UIBezierPath(arcCenter: CGPoint(x: 100, y: 100), radius: CGFloat(20), startAngle: CGFloat(0), endAngle: CGFloat(Double.pi * 2), clockwise: true) //CGPoint(x,y)의 위치가 원의 중심입니다.
let shapeLayer = CAShapeLayer()
shapeLayer.path = circlePath.cgPath //change the fill color
shapeLayer.fillColor = UIColor.clear.cgColor //you can change the stroke color
shapeLayer.strokeColor = UIColor.red.cgColor //you can change the line width
shapeLayer.lineWidth = 3.0
view.layer.addSublayer(shapeLayer)



//print(pow(0.1, 5.0))

let s = MfArray([[0.0, 0.1, 0.2],[1.0, 1.1, 1.2]])
let cnvtS = s.data.map { $0 as! Double }
print(cnvtS)
print(s[0,1])

if let s01 = s[0,1] as? Double,
   let s11 = s[0,1] as? Double {
    print(sqrt(1.0 - pow(s01, 2.0) - pow(s01, 2.0)))
}

//print(Matft.math.sqrt(MfArray([1.0 - pow(s[0,1] as! Double, 2.0) - pow(s[1,1] as! Double, 2.0)]) ) )
print(s)

//print(s)
//print(s[0,1])
//print(s * 2)
//let temp = Double(s.data[0])
//let temp = s.data[0]
//if let temp2 = s.data[0] as? Double {
//    let t = Double(temp2)
//    print(temp, t)
//}
//


//let testArr = [1, 2, 3, 4]
//let convArr = testArr.map { Double($0) }

//let t1 = MfArray([1,2,3,4])
//let t2 = MfArray([1,2,3,4]) * 1.0
//print("t1: \(t1) t2 : \(t2)")
//t1[0] = 2
//print(t1)
//t2[2] = 8
//print(t2)
