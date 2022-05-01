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


func projection(_ pole: SIMD3<Double>) -> SIMD2<Double> {
    let p_prime = SIMD2([pole[0]/(1-pole[2]), pole[1]/(1-pole[2])])
    
    return p_prime
}


func calcEulerAngle(_ angleX: Double, _ angleY: Double, _ angleZ: Double, _ standardPole: [SIMD3<Double>]) -> [SIMD3<Double>] {
    let radian = pi / 180.0
    let c1 = cos(angleX * radian)
    let c2 = cos(angleY * radian)
    let c3 = cos(angleZ * radian)
    let s1 = sin(angleX * radian)
    let s2 = sin(angleY * radian)
    let s3 = sin(angleZ * radian)
    
    let _0_0 = c2*c3
    let _0_1 = -c2*s3
    let _0_2 = s2
    let _1_0 = c1*s3+c3*s1*s2
    let _1_1 = c1*c3-s1*s2*s3
    let _1_2 = -c2*s1
    let _2_0 = s1*s3-c1*c3*s2
    let _2_1 = c3*s1+c1*s2*s3
    let _2_2 = c1*c2
    
    let raw1: SIMD3 = [_0_0, _0_1, _0_2]
    let raw2: SIMD3 = [_1_0, _1_1, _1_2]
    let raw3: SIMD3 = [_2_0, _2_1, _2_2]
    let XYZ: [SIMD3<Double>] = [raw1, raw2, raw3]
    
    return XYZ
}
