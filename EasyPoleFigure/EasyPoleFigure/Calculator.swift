//
//  Calculator.swift
//  EasyPoleFigure
//
//  Created by 추만석 on 2022/04/15.
//

import Foundation
import simd


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
