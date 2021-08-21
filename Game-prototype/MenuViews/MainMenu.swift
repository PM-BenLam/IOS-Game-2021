import SwiftUI

let lightGray: Color = Color.init(red: 0.8, green: 0.8, blue: 0.8)
let darkGray: Color = Color.init(red: 0.2, green: 0.2, blue: 0.2)
let lightRed: Color = Color.init(red: 1, green: 0.4, blue: 0.4)

struct MainMenu: View
{
    @Binding var currentPage: Page
    
    var body: some View
    {
        NavigationView
        {
            VStack
            {
                title
                
                buttons
                    
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background( Image("laptop1")
                            .resizable()
                            .scaledToFill())
            .edgesIgnoringSafeArea([.top, .bottom])
            
        }
    
    }
    
    var title: some View
    {
        Text("<遊戲名>")
            .bold()
            .font(.system(size: 50))
            .foregroundColor(Color.black)
            .padding([.bottom], 50)
            .padding([.top], 100)
            
    }
    
    var buttons: some View
    {
            
        
        VStack(spacing: 30)
        {
            
            Text("進入遊戲")
                .frame(maxWidth: 200, maxHeight: 80, alignment: .center)
                .font(.largeTitle)
                .foregroundColor(Color.black)
                .cornerRadius(10)
                .padding([.bottom], 15)
                .onTapGesture { currentPage = .ch1_Intro }
            
            
                
            
            NavigationLink(destination: InfoView())
            {
                Text("遊戲資訊")
                    .font(.title)
                    .foregroundColor(darkGray)
            }
            
            NavigationLink(destination: SettingView())
            {
                Text("設定")
                    .font(.title)
                    .foregroundColor(darkGray)
            }
            
            NavigationLink(destination: CreditView())
            {
                Text("鳴謝")
                    .font(.title)
                    .foregroundColor(darkGray)
                
            }
        }
        
    }
}
