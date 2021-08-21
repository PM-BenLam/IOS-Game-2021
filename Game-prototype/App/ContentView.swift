

import SwiftUI

struct ContentView: View
{
    @State var currentPage: Page = .mainMenu
    
    var body: some View
    {
        switch currentPage
        {
        case .mainMenu:
            MainMenu(currentPage: $currentPage)
                .transition(.opacity)
            
        case .gameView:
            GameView(currentPage: $currentPage)
                .transition(.opacity)
        
        }
    }
}

enum Page
{
    case mainMenu
    case gameView
}
