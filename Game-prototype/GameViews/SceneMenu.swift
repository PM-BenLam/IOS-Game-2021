
import SwiftUI

struct SceneMenu: View
{
    @Binding var currentPage: Page
    
    var body: some View
    {
        exitButton
        
        sceneList
        
        Spacer()
    }
    
    var exitButton: some View
    {
        HStack
        {
            Image(systemName: "chevron.backward.circle")
            
            Text("返回主頁")
        }
        .padding()
        .background(lightGray)
        .cornerRadius(10)
        .padding()
        .onTapGesture { currentPage = .mainMenu }
        .frame(maxWidth: .infinity, alignment: .leading)
        
    }
    
    var sceneList: some View
    {
        ScrollView
        {
            VStack(spacing: 30)
            {
                sceneCard(currentPage: $currentPage, title: "場景一", description: "你與同學對話，卻突然被威脅...", leadTo: .scene1)
                
                sceneCard(currentPage: $currentPage, title: "場景二", description: "你突然在社交平台上看到自己的私人資料被匿名人士公開...", leadTo: .mainMenu)
                
            }
            .padding([.leading, .trailing], 20)
        }
    }
}

struct sceneCard: View
{
    @Binding var currentPage: Page
    
    let title: String
    let description: String
    let leadTo: Page
    
    var body: some View
    {
        VStack
        {
            Text(title)
                .font(.largeTitle)
                .padding()
                
            Text(description)
                .font(.title2)
                .foregroundColor(darkGray)
                .fixedSize(horizontal: false, vertical: true)
            
            Spacer()
                
        }
        .frame(maxWidth: .infinity, maxHeight: 300)
        .padding(20)
        .background(lightGray)
        .cornerRadius(20)
        .onTapGesture { currentPage = leadTo }
    }
}
