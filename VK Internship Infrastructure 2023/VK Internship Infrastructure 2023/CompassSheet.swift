//
//  CompassSheet.swift
//  VK Internship Infrastructure 2023
//
//  Created by Ivan Vislov on 09.05.2023.
//

import SwiftUI

struct CompassSheet: View {
    @Binding var degrees: Double
    @Binding var show: Bool
    
    var body: some View {
        VStack(spacing: 25) {
            Text("Маршруты".uppercased())
                .font(.caption.weight(.medium))
                .opacity(0.5)
            
            // Избранные маршруты сейчас с mock данными, но код гибкий для модификации. Это функция для визуальной целостности приложения, при доработке можно реализовать добавление избранных мест, они будут отображаться на экране по координатам (как сейчас с mock данными), что поможет легче ориентироваться в пространстве и двигаться по компасу на них. Вдохновлено циферблатом с компасом на Apple Watch Ultra.
            WaypointView(rotation: 200, degrees: degrees)
            WaypointView(title: "Дом", latitude: "57.1526", longitude: "33.3159", icon: "house.fill", color: .red, rotation: 10, degrees: degrees)
            WaypointView(title: "Машина", latitude: "57.4573", longitude: "29.4588", icon: "car.fill", color: .green, rotation: 90, degrees: degrees)
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .opacity(show ? 1 : 0)
        .blur(radius: show ? 0 : 20)
        .foregroundColor(.white)
        .padding(40)
        .preferredColorScheme(.dark)
    }
}

struct CompassSheet_Previews: PreviewProvider {
    static var previews: some View {
        CompassSheet(degrees: .constant(0), show: .constant(true))
            .ignoresSafeArea(edges: .bottom)
    }
}

struct InfoRow: View {
    var title: String
    var text: String
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title.uppercased()).font(.caption)
                .opacity(0.5)
            Text(text)
        }
    }
}

struct WaypointView: View {
    var title = "Офис VK"
    var latitude = "59.9358"
    var longitude = "30.3258"
    var icon = "network"
    var color = Color.blue
    var rotation: Double = 0
    var degrees: Double = 0
    
    var body: some View {
        ZStack {
            ZStack {
                Circle()
                    .fill(.white.opacity(0.05))
                    .frame(width: 120)
                Circle()
                    .stroke(.linearGradient(colors: [.white.opacity(0.3), .clear], startPoint: .topLeading, endPoint: .bottomTrailing))
                    .frame(width: 120)
                    .overlay(
                        Circle().fill(color).frame(width: 28)
                            .overlay(Image(systemName: icon).font(.footnote).rotationEffect(.degrees(-degrees-rotation)))
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                    )
                Circle()
                    .fill(.white.opacity(0.02))
                    .frame(width: 80)
                Circle()
                    .stroke(.linearGradient(colors: [.white.opacity(0.3), .clear], startPoint: .topLeading, endPoint: .bottomTrailing))
                    .frame(width: 80)
                Circle()
                    .fill(.white.opacity(0.02))
                    .frame(width: 20)
                Circle()
                    .stroke(.linearGradient(colors: [.white.opacity(0.3), .clear], startPoint: .topLeading, endPoint: .bottomTrailing))
                    .frame(width: 20)
            }
            .rotationEffect(.degrees(degrees+rotation))
            
            VStack(spacing: 4) {
                Text(title)
                Text(latitude)
                    .font(.footnote).opacity(0.5)
                Text(longitude)
                    .font(.footnote).opacity(0.5)
            }
            .fontWeight(.medium)
            .foregroundColor(.white)
        }
    }
}
