//
//  SymmetryOperator.swift
//  EasyPoleFigure
//
//  Created by 천성원 on 2022/03/30.
//

import Foundation
import simd
///*
//General crystallographic symmetry operators
//Cubic and hexagonal operators are available.
//-- List of symmery operators
//def cubic()
//def hexag()
//def tetra()
//def triclinic()
//*/
//
//
//// 내적
//func dot(avector, bvector) {
//    var c = 0
//    for i in range 1...3 {
//        c = a[i]*b[i] + c
//    }
//}
//
// symmetry operators
// h는 넣어줄 행렬
func __60_120_rot111__(h :simd_double3x3) -> [simd_double3x3] {
    /*
    For the given h operation,
    rotations of (pi/3) & (2*pi/3) around <111>
    are performed and returned
    *cubic
    */
//    hx = h.copy()
    let hx = h
//    let h60 = np.zeros((3,3)) // 값이 0인 3*3 행렬
    var h60 = simd_double3x3(0)
//    let h120 = np.zeros((3,3))
    var h120 = simd_double3x3(0)
    h60[0, 2] = 1.0
    h60[1, 0] = 1.0
    h60[2, 1] = 1.0

    h120[0, 1] = 1.0
    h120[1, 2] = 1.0
    h120[2, 0] = 1.0

//    return np.dot(h60, hx), np.dot(h120, hx)
    return [h60 * hx, h120 * hx]
}
//
func __mirror_110__(h :simd_double3x3) -> simd_double3x3 {
    /*
    Given the operation h, mirrored across the (110) plane returned
    *cubic
    */
//    hx = h.copy()
    let hx = h
//    hm = np.zeros((3,3))
    var hm = simd_double3x3(0)
    hm[0, 1] = 1.0
    hm[1, 0] = 1.0
    hm[2, 2] = 1.0

    return hm * hx
}
//
//func __rot_90_180_270__(h) {
//    /*
//    Given the operation h,
//    the three rotated operations are returned
//    *cubic
//    */
////    cos = np.cos; sin = np.sin; pi = np.pi
//    let cos = Matft.math.cos
//    let sin = Matft.math.sin
//    let pi = Double.pi
////    hx = np.zeros((3,3,3))
//    let hx = MfArray([[0.0, 0.0, 0.0], [0.0, 0.0, 0.0], [0.0, 0.0, 0.0]])
////    h_ = h.copy(); htemp = []
//    let h_ = h.copy()
//    let htemp = [Double]()
//
//    for m in 0...3 {
////        ang = pi/2. * float(m+1)
//        let ang = pi / 2.0 * Double(m+1)
//        hx[m, 0, 0] = cos(ang)
//        hx[m, 1, 1] = cos(ang)
//        hx[m, 2, 2] = 1.0
//        hx[m, 0, 1] = -sin(ang)
//        hx[m, 1, 0] = sin(ang)
//        hx[m, 0, 2] = 0.0
//        hx[m, 2, 0] = 0.0
//        hx[m, 1, 2] = 0.0
//        hx[m, 2, 1] = 0.0
//        pass
//    }
//    for m in 0...3 {
//        htemp.append( np.dot(hx[m], h_) )
//        pass
//    }
////    return np.array(htemp)
//    return MfArray(htemp)
//}
//
func __rot_nrot_x1__(h: simd_double3x3, nrot: Int) -> simd_double3x3 {
    /*
    Mirror plane at 30 or 60 or 45 deg with respect to x1
    *hexagonal, trigonal, tetragonal
    hexa: nrot = 6
    trig: nrot = 3
    tetr: nrot = 4
    */
//    cos = np.cos; sin = np.sin; pi=np.pi
    let pi = Double.pi
//    hx = np.zeros((3,3))
    var hx = simd_double3x3(0.0)
//    ang = pi/float(nrot)
    let ang = pi / Double(nrot)
//    hx[0.0, 0] = cos(ang)**2 - sin(ang)**2
    hx[0, 0] = pow(cos(ang), 2) - pow(sin(ang), 2)
    hx[1, 1] = -h[0, 0]
    hx[2, 2] = 1.0
    hx[0, 1] = 2.0 * cos(ang) * sin(ang)
//    hx[1, 0] = h[0.0, 1.0]
    hx[1, 0] = h[0, 1]
    return hx * h
}
//
////func __rot_nrot_001__(h, csym=None) {
//func __rot_nrot_001__(h, csym: String) {
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
//    if csym == "hexag" {
//        let nrot = 6
//    } else if csym == "trigo" {
//        let nrot = 3
//    } else if csym == "tetra" {
//        let nrot = 4
//    } else {
//        print("Unexpected Error"); raise IOError
//    }
//
////    cos = np.cos; sin = np.sin; pi = np.pi
//    let cos = Matft.math.cos
//    let sin = Matft.math.sin
//    let pi = Double.pi
//    hx = np.zeros((nrot-1,3,3))
////    h_ = h.copy(); htemp = []
//    let h_ = h.copy()
//    let htemp = [Double]()
//
//    for nr in range(nrot-1):
//        ang = (nr + 1) * 2.0 * pi / nrot
//        hx[nr,0,0] = cos(ang)
//        hx[nr,1,1] = cos(ang)
//        hx[nr,2,2] = 1.0
//        hx[nr,0,1] = -sin(ang)
//        hx[nr,1,0] = sin(ang)
//
//    for nr in range(nrot-1):
//        htemp.append(np.dot(hx[nr], h_))
//
////    return np.array(htemp)
//    return MfArray(htemp)
//}
//
//func __trim0__(h) {
//    /*
//    if a value in the matrix h is fairly close to +-0.
//    then returns zero. In that way, trimming is performed
//    on the every component of given h matrix.
//    */
////    hx = h.copy()
//    let hx = h.copy()
////    for i in range(len(hx)):
////        for j in range(len(hx[i])):
////            if abs(hx[i,j]) < 0.1**6:
////                hx[i,j] = 0.
////    return hx
//    for i in range(len(hx)) {
//        for j in range(len(hx[i])) {
//            if abs(hx[i,j]) < 0.1**6 {
//                hx[i,j] = 0.0
//            }
//        }
//    }
//    return hx
//}
//
// -- mmm sample symmetry is found in COD_conv.py
func __mmm__() -> [[[Double]]] {
    let m0 = [[ 1.0, 0.0, 0.0], [0.0, 1.0, 0.0], [0.0, 0.0, 1.0]]
    let m1 = [[ 1.0, 0.0, 0.0], [0.0,-1.0, 0.0], [0.0, 0.0,-1.0]]
    let m2 = [[-1.0, 0.0, 0.0], [0.0, 1.0, 0.0], [0.0, 0.0,-1.0]]
    let m3 = [[-1.0, 0.0, 0.0], [0.0,-1.0, 0.0], [0.0, 0.0, 1.0]]
//    let m0 = MfArray([[ 1.0, 0.0, 0.0], [0.0, 1.0, 0.0], [0.0, 0.0, 1.0]])
//    let m1 = MfArray([[ 1.0, 0.0, 0.0], [0.0,-1.0, 0.0], [0.0, 0.0,-1.0]])
//    let m2 = MfArray([[-1.0, 0.0, 0.0], [0.0, 1.0, 0.0], [0.0, 0.0,-1.0]])
//    let m3 = MfArray([[-1.0, 0.0, 0.0], [0.0,-1.0, 0.0], [0.0, 0.0, 1.0]])
//    h = np.array([m0,m1,m2,m3])
    let h = [m0, m1, m2, m3]
    return h
}

//
//////deprecated
////func __ortho__(v) {
////    /*
////    Orthogonal sample symmetry to a vector (v) in 3D
////    */
////    v1 = np.aray([a[0], a[1], a[2]])
////    v2 = np.array([-a[0], a[1], a[2]])
////    v3 = np.array([a[0], -a[1], a[2]])
////    v4 = np.array([-a[0], -a[1], a[2]])
////
////    v5 = v1.copy()* -1
////    v6 = v2.copy()* -1
////    v7 = v3.copy()* -1
////    v8 = v4.copy()* -1
////
////    return v1, v2, v3, v4
////}
//
//
//// cubic symmetry
//func cubic() {
////    H = []
//    let H = [Double]() // H is the master list containing all the numpy arrays of operations
//    H.append(np.identity(3)) // identity operation
//    // What is '.identity()'????
//
//    // rotations of (pi/3) & (2*pi/3) around <111>
////    niter = len(H)
//    var niter = len(H)
//    for i in range(niter) {
//        h60 = __60_120_rot111__(h = H[i].copy())
//        h120 = __60_120_rot111__(h = H[i].copy())
//        h0 = h60.copy()
//        h1 = h120.copy()
//        H.append(h0)
//        H.append(h1)
//    }
//
//    // mirror across the plane (110)
//    niter = len(H)
//    for i in range(niter) {
//        h = __mirror_110__(h=H[i].copy())
//        H.append(h)
//    }
//    // rotations of 90, 180, 270 around x3
//    niter = len(H)
//    for i in range(niter){
//        h1, h2, h3 = __rot_90_180_270__(h = H[i].copy())
//        h90 = h1.copy()
//        h180 = h2.copy()
//        h270 = h3.copy()
//        H.append(h90)
//        H.append(h180)
//        H.append(h270)
//    }
////    H = np.array(H) // Make the H as numpy array
//    H = MfArray(H)
//
//    // trim the values.
//    for i in range(len(H)) {
//        H[i] = __trim0__(h=H[i])
//    }
//    return H
//}
//
// MARK: 여기까지 -------------------------------------------성원
//
// 임시 함수
func __trim0__(_ h: simd_double3x3) -> simd_double3x3 {
    return simd_double3x3()
}

func __rot_90_180_270__(_ h: simd_double3x3) -> [simd_double3x3] {
    return [simd_double3x3()]
}

//func __rot_nrot_x1__(_ h: simd_double3x3, nrot: Int) -> simd_double3x3 {
//    return simd_double3x3()
//}

func __rot_nrot_001__(_ h: simd_double3x3, csym: String) -> simd_double3x3 {
    return simd_double3x3()
}
// ------

func cubic() -> [simd_double3x3] {
    var H = [simd_double3x3(1)]
    
    for i in 0..<H.count {
        let (h60, h120) = (__60_120_rot111__(h: H[i])[0], __60_120_rot111__(h: H[i])[1])
        H.append(h60)
        H.append(h120)
    }
    
    for i in 0..<H.count {
        let h = __mirror_110__(h: H[i])
        H.append(h)
    }
    
    for i in 0..<H.count {
        let h = __rot_90_180_270__(H[i])
        let (h90, h180, h270) = (h[0], h[1], h[2])
        H.append(h90)
        H.append(h180)
        H.append(h270)
    }
    
    for i in 0..<H.count {
        H[i] = __trim0__(H[i])
    }
    
    return H
}

func cubic_centro() -> [simd_double3x3] {
    let h_old  = cubic()
    var h_new: [simd_double3x3] = []
    let h_n: simd_double3x3 = simd_double3x3(rows: [[-1,  0,  0],
                                                    [ 0, -1,  0],
                                                    [ 0,  0, -1]])
    
    for i in 0..<h_old.count {
        h_new.append(h_old[i] * h_n)
    }
    
    return h_new
}

func triclinic() -> [simd_double3x3] {
    let H = simd_double3x3(1)
    return [H]
}

// hexagonal
func hexag() -> [simd_double3x3] {
    var H = [simd_double3x3]()
    // mirror plane at 30 degree with respect to x1
    let nrot = 6

    for i in 0..<3 {
        H.append(__rot_nrot_x1__(h: H[i], nrot: nrot))
    }

//    rotations of 2*pi/6 around axis <001> for hexagonals.
    for i in 0..<3 {
        let h = __rot_nrot_001__(H[i], csym: "hexag")
        H.append(h)
    }

    for i in 0..<H.count {
        H[i] = __trim0__(H[i])
    }
    
    return H
}
//## orthorhombic
func ortho() -> [double3x3]{
    var H = [double3x3(1)]

    // 180 deg rotation around (001)
    H.append(makeRotationMatrix(angle: Double.pi))

    // x-mirror & y-mirror
    var hXMirror = double3x3(1)
    hXMirror[0,0] = -1
    H.append(hXMirror)
    
    var hYMirror = double3x3(1)
    hYMirror[1,1] = -1
    H.append(hYMirror)
    
    return H
}

// trigonal
func trigo() -> [double3x3] {
    var H = [double3x3(1)]
    
//    mirror plane 60 degree with respect to x1
    for i in 0..<H.count {
        let h = __rot_nrot_x1__(h: H[i], nrot: 3)
        H.append(h)
    }
    
//    #rotations of 2*pi/3 around axis <001> for trigonals
    for i in 0..<H.count {
        let h = __rot_nrot_001__(H[i], csym: "trigo")
        H.append(h)
    }

    for i in 0..<H.count {
        H[i] = __trim0__(H[i])
    }
    
    return H
}


////func tetra():
////    H = []
////    H.append(np.identity(3))
////
//////    #mirror plane at 45 degree with respect to x1
////    nrot = 4
////    niter = len(H)
////    for i in range(niter):
////        h = __rot_nrot_x1__(h=H[i].copy(), nrot=nrot)
////        H.append(h)
////
////    #rotations of 2*pi/4 around axis <001> for hexagonals.
////    niter = len(H)
////    for i in range(niter):
////        h = __rot_nrot_001__(h=H[i], csym='tetra')
////        for ix in range(len(h)):
////            H.append(h[ix])
////
////    for i in range(len(H)):
////        H[i] = __trim0__(h=H[i])
////    return H
////
////
//func cvec(cdim: [Double]? = nil, cang: [Double]? = nil) -> MfArray {
//                /*
//    """
//    Generates and returns 'cvec[i,n]' of the unit cell that
//    is characterized by unit cell dimension together with
//    axes' angles
//    ---------
//    Arguments
//      cdim=[1.,1.,1.]
//      cang=[90.,90.,90.] : Should be in angle [90.,90.,90.] not radian
//    """
//                 */
////    # angle to radian
//    var cang = cang * Double.pi/180
////    # cvec
//    var cvec = MfArray([[0, 0, 0],[0, 0, 0],[0, 0, 0]]) * 1.0
//    // 1열값 설정
//    cvec[0,0] = sin(cang[1])
//    cvec[1,0] = 0.0
//    cvec[2,0] = cos(cang[1])
//    // 2열값 설정
//    cvec[0,1] = (cos(cang[2]) - cos(cang[0]) * cos(cang[1])) / sin(cang[1])
//    cvec[2,1] = cos(cang[0])
////    cvec[1,1] = Matft.math.sqrt(1.0 - pow(cvec[0,1] as! Double, 2.0) - pow(cvec[2,1] as! Double, 2.0))
//    if let cvec01 = cvec[0,1] as? Double, let cvec21 = cvec[2,1] as? Double {
//        cvec[1,1] = sqrt(1.0 - pow(cvec01, 2.0) - pow(cvec21, 2.0))
//    }
//    // 3열값 설정
//    cvec[0,2] = 0.0
//    cvec[1,2] = 0.0
//    cvec[2,2] = 1.0
//
//    for i in 0..<3 {
//        for j in 0..<3 {
//            cvec[i,j] = cdim[j] * cvec[i,j]
//        }
//    }
//    
//    return cvec
//}
//
//func cv(pole: [Double], cdim: [Double]? = nil, cang: [Double]? = nil) -> MfArray {
//                /*
//    """
//    Creats vector of the pole taking care of its unit cell's
//    dimension and axes' angles.
//    """
//                 */
//    let sqrt = Matft.math.sqrt
//    cvect = cvec(cdim, cang)
//
////    s = np.zeros((3,))
//    var s = MfArray([0.0, 0.0, 0.0])
//    s[2] = ( pole[2]                                     ) / cvect[2,2]
//    s[0] = ( pole[0] - cvect[2,0]*s[2]                   ) / cvect[0,0]
//    s[1] = ( pole[1] - cvect[0,1]*s[0] - cvect[2,1]*s[2] ) / cvect[1,1]
//
//    let norm = sqrt(pow(s[0], 2) +  pow(s[1], 2) + pow(s[2], 2))
////    for i in range(3):
////        s[i] = s[i]/norm
////        if abs(s[i])<0.1**5: s[i]=0.
//    for i in 0..<3 {
//        s[i] = s[i] / norm
//        if abs(s[i]) < pow(0.1, 5.0) {
//            s[i] = 0
//        }
//    }
//                
//    return s
//}
//



func __rot_90_180_270__(h: simd_double3x3) -> [simd_double3x3] {
    /*
    Given the operation h,
    the three rotated operations are returned
    *cubic
    */
    var H: [simd_double3x3] = []
    var hx = [simd_double3x3(), simd_double3x3(), simd_double3x3()]
    
    for m in 0..<3 {
        let ang = Double.pi/2 * Double(m+1)
        hx[m] = makeRotationMatrix(angle: ang)
    }
    
    for m in 0..<3 {
        H.append(hx[m] * h)
    }
    
    return H
}

func makeRotationMatrix(angle: Double) -> simd_double3x3 {
    let rows = [
        simd_double3(cos(angle), -sin(angle), 0),
        simd_double3(sin(angle), cos(angle), 0),
        simd_double3(0,          0,          1)
    ]
    print(rows)
    
    return double3x3(rows)
}

