import SwiftUI

protocol TabBarButtonRepresentable: Identifiable, Equatable {
    var name: String { get }
    var imageName: String { get }
    var selectedImageName: String { get }
}

struct TabBarButton<TabType: TabBarButtonRepresentable>: View {
    let tab: TabType

    @Binding
    var selectedTab: TabType

    var body: some View {
        Button(
            action: {
                selectedTab = tab
            },
            label: {
                VStack(spacing: 6) {
                    Image(systemName: selectedTab == tab ? tab.selectedImageName : tab.imageName)
                        .resizable()
                        .foregroundColor(Color.textPrimary)
                        .frame(width: 24, height: 24)
                        .padding([.top, .leading, .trailing], 4)
                    Text(tab.name)
                        .font(.footnote)
                        .foregroundColor(Color.textPrimary)
                        .frame(maxWidth: .infinity)
                }
            }
        )
    }
}

struct TabBarButton_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.background.ignoresSafeArea()
            TabBarButton(tab: DashboardRoute.home, selectedTab: .constant(.home))
        }
    }
}
