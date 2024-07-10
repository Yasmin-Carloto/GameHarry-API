//
//  ReviewTimer.swift
//  gameHarry-API
//
//  Created by Yasmin Carloto on 09/07/24.
//

import SwiftUI

struct ReviewTimer: View {
    @State var offset: CGFloat = 30
    @Binding private var timePassedValue: Double
    private var bounds: ClosedRange<Int>
    
    init(
        timePassedValue: Binding<Double>,
        in bounds: ClosedRange<Int>
    ){
        self._timePassedValue = timePassedValue
        self.bounds = bounds
    }
    
    var body: some View {
        VStack{
            GeometryReader{ reader in
                ZStack(alignment: Alignment(horizontal: .leading, vertical: .center), content: {
                    Capsule()
                        .fill(Color.champagnePink)
                        .frame(height: 20)
                        .frame(maxWidth: reader.size.width)
                    
                    Capsule()
                        .fill(
                            LinearGradient(gradient: Gradient(colors: [Color.lightMaroon, Color.roseEbony]), startPoint: .bottom, endPoint: .top)
                        )
                        .frame(width: offset, height: 20)
                    
                    Image("houglass-icon")
                        .frame(width: 35, height: 35, alignment: .center)
                        .offset(x: offset - 16)
                        .onChange(of: timePassedValue) { oldValue, newValue in
                            let totalWidth = reader.size.width
                            updateOffset(totalWidth: totalWidth)
                        }
                })
                .onAppear(perform: {
                    offset = reader.size.width
                })                
            }
        }
        .frame(height: 50)
    }
    
    private func updateOffset(totalWidth: CGFloat) {
        let percentage = CGFloat((timePassedValue - Double(bounds.lowerBound)) / Double(bounds.upperBound - bounds.lowerBound))
        DispatchQueue.main.async{
            self.offset = percentage * totalWidth
        }
    }
}

#Preview {
    ReviewTimer(timePassedValue: .constant(10), in: 1...10)
}
