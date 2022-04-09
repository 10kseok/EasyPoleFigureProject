import UIKit
import Matft
import simd

// MARK: 정규화, 주어진 좌표를 길이가 1이 되게끔 맞춰줌
let normal = simd_normalize(simd_double3(x: 2.7, y: 2.1, z: 1.2))
print(normal)

// MARK: 0으로 채워진 3x1행렬 만들기 = np.zeros((3,))
let zero3x1Matrix = simd_double3()
print("zero3x1Matrix = ",zero3x1Matrix)

// MARK: 0으로 채워진 3x3행렬 만들기 = np.zeros((3,3))
let zero3x3Matrix = simd_double3x3(5.0)
print("zero3x3Matrix = ",zero3x3Matrix)

// MARK: 0으로 채워진 3x3x3행렬 만들기 = np.zeros((3,3,3))
let zero3x3x3Matrix: [simd_double3x3] = [simd_double3x3(), simd_double3x3(), simd_double3x3()]
print("zero3x3x3Matrix = ",zero3x3x3Matrix)

// MARK: 3x3 단위행렬 만들기 = np.identity(3)
let one3X3Matrix = simd_double3x3(1)
print("one3X3Matrix = ",one3X3Matrix)

// MARK: 행렬 회전, 라디안값으로 넣어줘야함
/* 아래 코드와 동일
hx[0,0] = cos(ang)
hx[1,1] = cos(ang)
hx[2,2] = 1.0
hx[0,1] = -sin(ang)
hx[1,0] = sin(ang)
hx[0,2] = 0.
hx[2,0] = 0.
hx[1,2] = 0.
hx[2,1] = 0.
 */
func makeRotationMatrix(angle: Double) -> simd_double3x3 {
    let rows = [
        simd_double3(cos(angle), -sin(angle), 0),
        simd_double3(sin(angle), cos(angle), 0),
        simd_double3(0,          0,          1)
    ]
    
    return double3x3(rows: rows)
}



let h_n: simd_double3x3 = simd_double3x3(rows: [[-1,1,7],[1,-1,-21],[2,1,-1]])
let tempDot = simd_double3x3(rows: [[-1,3,2],[2,-1,4],[3,2,-1]])
print(h_n * tempDot)


//print(simd_dot(simd_double2([2,1]), simd_double2([3,7])))




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

//print(pow(0.1, 5.0))
/*
let s = MfArray([[0.0, 0.1, 0.2],[1.0, 1.1, 1.2]])
let cnvtS = s.data.map { $0 as! Double }
print(cnvtS)
print(s[0,1])

if let s01 = s[0,1] as? Double,
   let s11 = s[0,1] as? Double {
    print(sqrt(1.0 - pow(s01, 2.0) - pow(s01, 2.0)))
}
 */

//print(Matft.math.sqrt(MfArray([1.0 - pow(s[0,1] as! Double, 2.0) - pow(s[1,1] as! Double, 2.0)]) ) )


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


//let temp = MfArray([1,2,3,4])
//let temp2 = temp.deepcopy()
//
//print(temp2)
//
func cubic() -> MfArray {
    return MfArray([[ 1,  0,  0,],
                    [ 0,  1,  0,],
                    [ 0,  0,  1]]) * 1.0
}

func cubic_centro() -> MfArray {
    let h_old: MfArray = cubic()
    let h_new: MfArray = MfArray([])
    let h_n: MfArray = MfArray([[ -1,  0,  0],
                                [  0, -1,  0],
                                [  0,  0, -1]]) * 1.0
    
    for i in 0..<h_old.count {
        _ = h_new.append(values: Matft.inner(h_old[i], h_n))
    }
    return h_new
}

//let temp1 = MfArray([1,0,0])
//let temp2 = MfArray([0,0,1])
//
//print(Matft.inner(temp1, temp2))
