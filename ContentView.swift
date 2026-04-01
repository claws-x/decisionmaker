//
//  ContentView.swift
//  DecisionMaker
//
//  Created by AI Agent on 2026-03-29.
//

import SwiftUI

struct ContentView: View {
    @State private var options: [String] = [""]
    @State private var isSpinning = false
    @State private var result: String?
    
    var body: some View {
        NavigationView {
            VStack(spacing: 30) {
                // 结果展示
                if let result = result {
                    VStack(spacing: 16) {
                        Text("决定")
                            .font(.headline)
                            .foregroundColor(.secondary)
                        Text(result)
                            .font(.system(size: 40, weight: .bold))
                            .foregroundColor(.blue)
                    }
                    .padding()
                }
                
                // 选项输入
                ForEach(0..<options.count, id: \.self) { index in
                    TextField("选项 \(index + 1)", text: $options[index])
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                
                Button(action: addOption) {
                    Label("添加选项", systemImage: "plus")
                        .padding()
                        .background(Color(.systemGray5))
                        .cornerRadius(8)
                }
                
                // 决定按钮
                Button(action: makeDecision) {
                    Label(isSpinning ? "决定中..." : "帮我决定", systemImage: "dice")
                        .font(.headline)
                        .padding()
                        .frame(width: 200)
                        .background(isSpinning ? Color.gray : Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }
                .disabled(isSpinning || validOptions.count < 2)
                
                Spacer()
            }
            .padding()
            .navigationTitle("决策助手")
        }
    }
    
    var validOptions: [String] {
        options.filter { !$0.trimmingCharacters(in: .whitespaces).isEmpty }
    }
    
    func addOption() {
        options.append("")
    }
    
    func makeDecision() {
        guard validOptions.count >= 2 else { return }
        isSpinning = true
        result = nil
        
        // 模拟旋转动画
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            result = validOptions.randomElement()
            isSpinning = false
        }
    }
}

#Preview {
    ContentView()
}
