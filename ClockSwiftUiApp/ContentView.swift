//
//  ContentView.swift
//  ClockSwiftUiApp
//
//  Created by Tornike Eristavi on 22.02.25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Home()
    }
}

struct Home: View {
    
    @State var currentTime = Time(hour: 0, minute: 0, second: 0)
    @State var receiver = Timer.publish(every: 1, on: .current, in: .default).autoconnect()
    var width = UIScreen.main.bounds.width
    
    var body: some View {
        ZStack {
            Color.blue.ignoresSafeArea()
            
            VStack {
                Text(getTime())
                    .font(.system(size: 50))
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.top, 20)
                
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.black)
                        .frame(width: width - 50, height: width - 70)
                        .shadow(color: Color.black.opacity(0.3), radius: 10, x: 10, y: 10)
                    
                    Circle()
                        .fill(Color.white)
                        .frame(width: width - 100, height: width - 100)
                        .shadow(radius: 5)
                    
                    ForEach(0..<12, id: \.self) { i in
                        Rectangle()
                            .fill(Color.black)
                            .frame(width: 4, height: (i % 3) == 0 ? 20 : 10)
                            .offset(y: -(width - 120) / 2)
                            .rotationEffect(.degrees(Double(i) * 30))
                    }
                    
                    Rectangle()
                        .fill(Color.black)
                        .frame(width: 6, height: (width - 220) / 2)
                        .offset(y: -(width - 220) / 4)
                        .rotationEffect(.degrees(Double(currentTime.hour % 12) * 30 + Double(currentTime.minute) / 2))
                    
                    Rectangle()
                        .fill(Color.black)
                        .frame(width: 4, height: (width - 160) / 2)
                        .offset(y: -(width - 160) / 4)
                        .rotationEffect(.degrees(Double(currentTime.minute) * 6))
                    
                    Rectangle()
                        .fill(Color.red)
                        .frame(width: 2, height: (width - 140) / 2)
                        .offset(y: -(width - 140) / 4)
                        .rotationEffect(.degrees(Double(currentTime.second) * 6))
                    
                    
                    Circle()
                        .fill(Color.black)
                        .frame(width: 10, height: 10)
                }
                .frame(width: width - 100, height: width - 100)
            }
            .onAppear(perform: updateTime)
            .onReceive(receiver) { _ in updateTime() }
        }
    }
    
    func updateTime() {
        let calendar = Calendar.current
        let sec = calendar.component(.second, from: Date())
        let min = calendar.component(.minute, from: Date())
        let hour = calendar.component(.hour, from: Date())

        withAnimation(.linear(duration: 0.01)) {
            currentTime = Time(hour: hour, minute: min, second: sec)
        }
    }

    func getTime() -> String {
        let format = DateFormatter()
        format.dateFormat = "hh:mm a"
        return format.string(from: Date())
    }
}

struct Time {
    var hour: Int
    var minute: Int
    var second: Int
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

