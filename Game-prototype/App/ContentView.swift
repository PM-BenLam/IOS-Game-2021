

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
        case .sceneMenu:
            SceneMenu(currentPage: $currentPage)
        case .scene1:
            Scene1()
        }
    }
}

enum Page
{
    case mainMenu
    case sceneMenu
    case scene1
}
