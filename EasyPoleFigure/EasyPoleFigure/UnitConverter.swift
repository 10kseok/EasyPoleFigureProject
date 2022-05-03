//
//  UnitConverter.swift
//  EasyPoleFigure
//
//  Created by 추만석 on 2022/05/04.
//

import Foundation


func convertRadianToDegree(radian: Float) -> Float {
    return radian * 180 / Float.pi
}

func convertRadianToDegree(radian: Double) -> Double {
    return radian * 180 / Double.pi
}

func convertDegreeToRadian(degree: Float) -> Float {
    return degree * Float.pi / 180
}

func convertDegreeToRadian(degree: Double) -> Double {
    return degree * Double.pi / 180
}


