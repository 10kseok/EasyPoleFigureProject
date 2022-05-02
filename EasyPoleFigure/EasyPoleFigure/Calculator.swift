//
//  Calculator.swift
//  EasyPoleFigure
//
//  Created by 추만석 on 2022/04/15.
//

import Foundation
import simd


let pi = Double.pi

func dotP(_ symmetryOperator: double3x3,_ milerIdx: SIMD3<Double>) -> SIMD3<Double> {
    let x = dot(symmetryOperator[0], milerIdx)
    let y = dot(symmetryOperator[1], milerIdx)
    let z = dot(symmetryOperator[2], milerIdx)
    return SIMD3<Double>(x: x, y: y, z: z)
}

func dotP2(_ XYZ: [SIMD3<Double>],_ milerIdx: SIMD3<Double>) -> SIMD3<Double> {
    let x = dot(XYZ[0], milerIdx)
    let y = dot(XYZ[1], milerIdx)
    let z = dot(XYZ[2], milerIdx)
    return SIMD3<Double>(x: x, y: y, z: z)
}


func projection(_ pole: SIMD3<Double>) -> SIMD2<Double> {
    let p_prime = SIMD2([pole[0]/(1-pole[2]), pole[1]/(1-pole[2])])
    
    return p_prime
}


//func calcEulerAngle(_ angleX: Double, _ angleY: Double, _ angleZ: Double, _ standardPole: [SIMD3<Double>]) -> [SIMD3<Double>] {
func calcEulerAngle(_ angleX: Double, _ angleY: Double, _ angleZ: Double) -> [SIMD3<Double>] {

    let c1 = cos(angleX)
    let c2 = cos(angleY)
    let c3 = cos(angleZ)
    let s1 = sin(angleX)
    let s2 = sin(angleY)
    let s3 = sin(angleZ)
    
    let _0_0 = c2*c3
    let _0_1 = -c2*s3
    let _0_2 = s2
    let _1_0 = c1*s3+c3*s1*s2
    let _1_1 = c1*c3-s1*s2*s3
    let _1_2 = -c2*s1
    let _2_0 = s1*s3-c1*c3*s2
    let _2_1 = c3*s1+c1*s2*s3
    let _2_2 = c1*c2
    

    let raw1: SIMD3<Double> = [_0_0, _0_1, _0_2]
    let raw2: SIMD3<Double> = [_1_0, _1_1, _1_2]
    let raw3: SIMD3<Double> = [_2_0, _2_1, _2_2]
    let XYZ: [SIMD3<Double>] = [raw1, raw2, raw3]
    
    //let rotatedP = dotP(XYZ, <#T##milerIdx: SIMD3<Double>##SIMD3<Double>#>)
    // 여기에서 XYZ, standardPole 내적시켜야할듯
    // XYZ: 3x3, standardPole(pDotH): [1x3]
    // 
    return XYZ
}
