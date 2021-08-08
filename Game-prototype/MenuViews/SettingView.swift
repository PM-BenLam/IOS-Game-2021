
import SwiftUI

struct SettingView: View
{
    var body: some View
    {
        List
        {
            Text("Setting")
                .padding()
            Text("Another Setting")
                .padding()
            
        }
        .padding([.top], 30)
        .frame(maxHeight: .infinity)
        .navigationTitle("設定")
    }
}

