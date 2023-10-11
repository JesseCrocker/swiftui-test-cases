//
//  ContentView.swift
//  SheetTest
//
//  Created by Jesse Crocker on 10/11/23.
//

import SwiftUI

struct ContentView: View {
    enum container {
        case container1
        case container2
    }
    
    @State var currentContainer: container = .container1
    
    var body: some View {
        if currentContainer == .container1 {
            Container1(container: $currentContainer)
        } else {
            Container2(container: $currentContainer)
        }
    }
}

struct Container1: View {
    @State var sheet1: Bool = false
    @Binding var container: ContentView.container
    
    var body: some View {
        VStack {
            VStack {
                Text("I am container 1")

                Button("Show Sheet 1") {
                    sheet1 = true
                }
                Button("Show Container 2") {
                    container = .container2
                }
            }
            .padding()
            .sheet(isPresented: $sheet1) {
                Sheet1(container: $container)
            }
        }
    }
}

struct Container2: View {
    @State var sheet2: Bool = false
    @Binding var container: ContentView.container

    var body: some View {
        VStack {
            Text("I am container 2")
            Text("sheet2 =\(String(describing: sheet2))")
            Button("Show Sheet 2") {
                sheet2 = true
            }
            Button("Show Container 1") {
                container = .container1
            }
            Spacer()
        }.onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                sheet2 = true
            }
        }
        .padding()
        .sheet(isPresented: $sheet2) {
            Sheet2()
        }
    }
}

struct Sheet1 : View {
    @Environment(\.dismiss) private var dismiss
    @Binding var container: ContentView.container
    
    var body: some View {
        VStack {
            Text("I am sheet 1")
            Button("Show container 2 with dismiss") {
                dismiss()
                container = .container2
            }
            Button("Show container 2 without dismiss") {
                container = .container2
            }
        }
        .padding()
        .presentationDetents([.medium])
        .presentationDragIndicator(.visible)
    }
}

struct Sheet2 : View {
    var body: some View {
        VStack {
            Text("I am sheet 2")
        }
        .presentationDetents([.medium])
        .presentationDragIndicator(.visible)
    }
}

#Preview {
    ContentView()
}
