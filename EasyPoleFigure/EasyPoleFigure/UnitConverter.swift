//
//  UnitConverter.swift
//  EasyPoleFigure
//
//  Created by 추만석 on 2022/05/04.
//

import Foundation


func convertRadianToDegree(_ radian: Float) -> Float {
    return radian * 180 / Float.pi
}

func convertRadianToDegree(_ radian: Double) -> Double {
    return radian * 180 / Double.pi
}

func convertRadianToDegree(_ radian: Int) -> Int {
    return radian * 180 / Int(Float.pi)
}

func convertDegreeToRadian(_ degree: Float) -> Float {
    return degree * Float.pi / 180
}

func convertDegreeToRadian(_ degree: Double) -> Double {
    return degree * Double.pi / 180
}

func convertDegreeToRadian(_ degree: Int) -> Int {
    return degree * Int(Double.pi) / 180
}


