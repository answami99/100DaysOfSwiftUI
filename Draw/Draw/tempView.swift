//
//  tempView.swift
//  Draw
//
//  Created by Aditya Narayan Swami on 16/12/21.
//

import SwiftUI

struct Arrow: Shape{
    var changeInWidth: Double
    
    var animatableData: Double{
        get { changeInWidth }
        set { changeInWidth = newValue }
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.size.width/2, y: 0))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.size.height/4))
        path.addLine(to: CGPoint(x: ((3*rect.maxX)/4)-changeInWidth, y: rect.size.height/4))
        path.addLine(to: CGPoint(x: ((3*rect.maxX)/4)-changeInWidth, y: rect.maxY))
        path.addLine(to: CGPoint(x: ((rect.maxX)/4)+changeInWidth , y: rect.maxY))
        path.addLine(to: CGPoint(x: ((rect.maxX)/4)+changeInWidth, y: rect.size.height/4))
        path.addLine(to: CGPoint(x: 0, y: rect.size.height/4))
        return path
    }
}


struct LeftEye: Shape{
    var endAngle: Double
    var animatableData: Double{
        get { endAngle }
        set { endAngle = newValue }
    }
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.addArc(center: CGPoint(x: rect.midX/2, y: rect.midY/2), radius: rect.size.width/10, startAngle: Angle.degrees(0), endAngle: Angle.degrees(endAngle), clockwise: false)
        return path
        
    }
}
struct RightEye: Shape{
    var endAngle: Double
    var animatableData: Double{
        get { endAngle }
        set { endAngle = newValue }
    }
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.addArc(center: CGPoint(x: (3*rect.midX)/2, y: rect.midY/2), radius: rect.size.width/10, startAngle: Angle.degrees(180), endAngle: Angle.degrees(endAngle-180), clockwise: true)
        return path
        
    }
}
struct Mouth: Shape{
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.addArc(center: CGPoint(x: rect.midX, y: rect.midY), radius: rect.size.width/4, startAngle: Angle.degrees(0), endAngle: Angle.degrees(180), clockwise: false)
        return path
    }
}


struct CheckBoard: Shape{
    var rows: Int
    var columns: Int
    
    var animatableData: AnimatablePair<Double, Double>{
        get{ AnimatablePair(Double(rows), Double(columns)) }
        set {
            rows = Int(newValue.first)
            columns = Int(newValue.second)
        }
    }
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let rowSize = rect.height / Double(rows)
        let columnSize = rect.width / Double(columns)
        
        for row in 0..<rows{
            for column in 0..<columns{
                if (row + column).isMultiple(of: 2) {
                    let startX = columnSize * Double(column)
                    let startY = rowSize * Double(row)
                    path.addRect(CGRect(x: startX, y: startY, width: columnSize, height: rowSize))
                }
            }
        }
        return path
    }
}
struct Trapazoid: Shape{
    var amount: Double
    var animatableData: Double{
        get { amount }
        set { amount = newValue }
    }
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: 0, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX - amount, y: rect.minY))
        path.addLine(to: CGPoint(x: amount, y: rect.minY))
        path.addLine(to: CGPoint(x: 0, y: rect.maxY))
        
        return path
    }
}
struct ColorCyclingCircle: View{
    var amount = 0.0
    var steps = 100
    
    var body: some View{
        ZStack{
            ForEach(0..<steps){ value in
                Circle()
                    .inset(by: Double(value))
                    .strokeBorder(
                        LinearGradient(
                            gradient: Gradient(colors: [
                                color(for: value, brightness: 1),
                                color(for: value, brightness: 0.4)]),
                            startPoint: .top,
                            endPoint: .bottom),
                        lineWidth: 2)
            }
        }
        .drawingGroup()
    }
    func color(for value: Int, brightness: Double) -> Color{
        var targetHue = (Double(value) / Double(steps)) + amount
        if targetHue > 1{
            targetHue -= 1
        }
        return Color(hue: targetHue, saturation: 1, brightness: brightness)
    }
}

struct Arc: InsettableShape{
    let startAngle: Angle
    let endAngle: Angle
    let clockWise: Bool
    var insetAmount = 0.0
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.addArc(center: CGPoint(x: rect.midX, y: rect.midY), radius: rect.width/2 - insetAmount, startAngle: startAngle - Angle.degrees(90), endAngle: endAngle - Angle.degrees(90), clockwise: !clockWise)
        return path
    }
    func inset(by amount: CGFloat) -> some InsettableShape{
        var arc = self
        arc.insetAmount += amount
        return arc
    }
}
struct Flower: Shape{
    var petalOffset: Double = -20
    // petal offset will move our petal away from the center.
    var petalWidth: Double = 100
    // width of each petal
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        //This path object will hold all of our petals.
        //To do this we could use Range 1... how many we want but in our case we have a range with certain difference (pi/8), for this a better option is to use method called stride.
        for number in stride(from: 0, to: Double.pi * 2, by: Double.pi / 8){
            //this will count from 0 - 360 with gap of 22.5
            let rotation = CGAffineTransform(rotationAngle: number)
            // rotate our petal with current value
            let position = rotation.concatenating(CGAffineTransform(translationX: rect.width/2, y: rect.height/2))
            // this is move the position of our petal after rotation, we are add ing one CGAffineTransform into another.
            let originalPetal = Path(ellipseIn: CGRect(x: petalOffset, y: 0, width: petalWidth, height: rect.width/2))
            //this will create a ellipse with our offset and width and height
            let rotatedPetal = originalPetal.applying(position)
            //This applies rotation and then position on our petal.
            path.addPath(rotatedPetal)
            //this adds our petal to main path
        }
        return path
    }
}
struct tempView: View {
    @State private var petalOffset = -20.0
    @State private var petalWidth = 100.0
    var body: some View {
        VStack{
            Flower(petalOffset: petalOffset, petalWidth: petalWidth)
               // .fill(.red, style: FillStyle(eoFill: true))
                .stroke(.red, lineWidth: 2)
            Text("Offset")
            Slider(value: $petalOffset, in: -40...40)
                .padding(.horizontal)
            Text("Width")
            Slider(value: $petalWidth, in: 0...100)
                .padding(.horizontal)
        }
    }
}

struct tempView_Previews: PreviewProvider {
    static var previews: some View {
        tempView()
    }
}
