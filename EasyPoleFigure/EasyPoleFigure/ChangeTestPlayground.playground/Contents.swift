import UIKit
import simd

// pole = dot(h, v)
let h = simd_double3x3(2)
print(h[0])
// MARK: 정규화, 주어진 좌표를 길이가 1이 되게끔 맞춰줌
let normal = simd_normalize(simd_double3(x: 2.7, y: 2.1, z: 1.2))
print(normal)

let cubicMillerIdx = [[0.0,0.0,1.0], [1.0,0.0,0.0], [0.0,1.0,0.0], [1.0,0.0,1.0], [1.0,1.0,0.0], [0.0,1.0,1.0], [1.0,1.0,1.0], [1.0,-1.0,1.0], [-1.0,1.0,1.0]]
print(cubicMillerIdx[3])
print(cubicMillerIdx[3][0])
print(cubicMillerIdx[3][1])
print(cubicMillerIdx[3][2])

print(simd_normalize(simd_double3(x: Double(cubicMillerIdx[3][0]), y: Double(cubicMillerIdx[3][1]), z: Double(cubicMillerIdx[3][2]))))
var normalCubicMillerIdx = [simd_double3]()

for i in cubicMillerIdx {
    normalCubicMillerIdx.append(simd_normalize(simd_double3(x: i[0], y: i[1], z: i[2])))
    }
print(normal)
print(normalCubicMillerIdx)

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
/*
 1 0 0
 0 1 0
 0 0 1
 */
let one3X3Matrix = simd_double3x3(1)
print("one3X3Matrix = ",one3X3Matrix)

simd_double3x3()



// MARK: 잘 모르겠구만
////func __rot_nrot_001__(h, csym=None) {
//func __rot_nrot_001__(h: double3x3, csym: String) -> [double3x3]{
//    /*
//    Rotations of 2*pi/nrot around axis <001>
//    *hexagoanl, trigonal, tetragonal
//    ---------
//    Arguments
//    h: symmetry operators
//    csym: 'hexa'
//    */
////    if   csym=='hexag': nrot=6
////    elif csym=='trigo': nrot=3
////    elif csym=='tetra': nrot=4
////    else: print('Unexpected Error'); raise IOError
//    var nrot: Double
//    if csym == "hexag" {
//        nrot = 6.0
//    } else if csym == "trigo" {
//        nrot = 3.0
//    } else if csym == "tetra" {
//        nrot = 4.0
//    } else {
//        print("Unexpected Error"); raise IOError
//    }
//
////    cos = np.cos; sin = np.sin; pi = np.pi
//    let pi = Double.pi
////    hx = np.zeros((nrot-1,3,3))
//    var hx: [simd_double3x3] = [simd_double3x3(nrot-1.0), simd_double3x3(3.0), simd_double3x3(3.0)]
////    h_ = h.copy(); htemp = []
//    let h_ = h
//    let htemp = [double3x3]()
//
//    for nr in Int(nrot-1) {
//        ang = (nr + 1) * 2.0 * pi / nrot
//        hx[nr,0,0] = cos(ang)
//        hx[nr,1,1] = cos(ang)
//        hx[nr,2,2] = 1.0
//        hx[nr,0,1] = -sin(ang)
//        hx[nr,1,0] = sin(ang)
//    }
//    for nr in nrot-1 {
//        htemp.append(hx[nr] * h_)
//    }
//
////    return np.array(htemp)
//    return [htemp]
//}
//func __trim0__(h: simd_double3x3) -> simd_double3x3 {
//    /*
//    if a value in the matrix h is fairly close to +-0.
//    then returns zero. In that way, trimming is performed
//    on the every component of given h matrix.
//    */
////    hx = h.copy()
//    let hx = h
////    for i in range(len(hx)):
////        for j in range(len(hx[i])):
////            if abs(hx[i,j]) < 0.1**6:
////                hx[i,j] = 0.
////    return hx
//    for i in hx {
//        for j in hx[i] {
//            if abs(hx[i,j]) < 0.1**6 {
//                hx[i,j] = 0.0
//            }
//        }
//    }
//    return hx
//}
//func __rot_90_180_270__(h :[simd_double3x3]) -> [simd_double3x3] {
//    /*
//    Given the operation h,
//    the three rotated operations are returned
//    *cubic
//    */
////    cos = np.cos; sin = np.sin; pi = np.pi
////    let cos = simd.cos()
////    let sin = Matft.math.sin
//    let pi = Double.pi
////    hx = np.zeros((3,3,3))
//    let hx = [simd_double3x3(0), simd_double3x3(0), simd_double3x3(0)]
////    h_ = h.copy(); htemp = []
//    let h_ = h
//    let htemp = [Double]()
//    for m in 0...3 {
////        ang = pi/2. * float(m+1)
//        let ang = pi / 2.0 * Double(m+1)
//        hx[m, 0, 0] = simd.cos(ang)
//        hx[m, 1, 1] = cos(ang)
//        hx[m, 2, 2] = 1.0
//        hx[m, 0, 1] = -sin(ang)
//        hx[m, 1, 0] = sin(ang)
//        hx[m, 0, 2] = 0.0
//        hx[m, 2, 0] = 0.0
//        hx[m, 1, 2] = 0.0
//        hx[m, 2, 1] = 0.0
//        //pass
//    }
//    for m in 0...3 {
//        //htemp.append( np.dot(hx[m], h_) )
//        htemp.append(hx[m] * h)
//        //pass
//    }
////    return np.array(htemp)
//    return MfArray(htemp)
//}

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
print("h_n * tempDot = ",h_n * tempDot)


print("simd_dot = ", simd_dot(simd_double2([2,1]), simd_double2([3,7])))



//// stereographic projection 계산식
//// [X, Y] = [x/(1-z), y/(1-z)]
//func projection(_ pole: [Double]) -> [Double] {
//    let p_prime = [pole[0]/(1-pole[2]), pole[1]/(1-pole[2])]
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

//let temp1 = MfArray([1,0,0])
//let temp2 = MfArray([0,0,1])
//
//print(Matft.inner(temp1, temp2))
