//
//  TestProgress.swift
//  FoodRecipe
//
//  Created by Tuấn Vũ Trụ on 16/09/2023.
//

import SwiftUI

struct TestProgress: View {
    
    @State private var isLoading = false
    var body: some View {
        
        ZStack{
            
            VStack{
                Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                
            }
            //MARK: DELAY SAMPLE IN 5 SECONDS
            if isLoading {
                ZStack {
                    Color(.black)
                        .ignoresSafeArea()
                        .opacity(0.5)
                        .background(Color.clear)
                    
                    Progress(loadingSize: 3)
                }
            }
        }
        .onAppear() {
            fakeAsyncUI()
        }
        
    }
    

    // mn có thể dùng trong if else function để bắt điều kiện loading mà không cần set time để cho loading đúng nhé
    // eg: if dataAppear{render Ui}
    //     else {Progress(loadingSize: Int)}
    //MARK: FAKE ASYNC IN 3 SECCOND
    func fakeAsyncUI() {
        isLoading = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            isLoading = false
        }
    }
    
}

struct TestProgress_Previews: PreviewProvider {
    static var previews: some View {
        TestProgress()
    }
}
