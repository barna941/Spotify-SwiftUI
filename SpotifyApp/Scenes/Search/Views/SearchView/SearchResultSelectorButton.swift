import SwiftUI

struct SearchResultSelectorButton: View {

    let searchType: SearchModel.SearchType
    let action: () -> Void

    @Binding
    var selectedType: SearchModel.SearchType

    private var isSelected: Bool {
        selectedType == searchType
    }

    var body: some View {
        Button(
            action: {
                selectedType = searchType
                action()
            },
            label: {
                Text(searchType.rawValue)
                    .font(.title3)
                    .foregroundColor(.white)
                    .padding(EdgeInsets(top: 4, leading: 16, bottom: 4, trailing: 16))
                    .overlay(
                        Capsule()
                            .strokeBorder()
                            .foregroundColor(isSelected ? Color.primary : Color.white.opacity(0.7))
                    )
                    .background(
                        Capsule().foregroundColor(isSelected ? Color.primary.opacity(0.9) : .clear)
                    )
            }
        )
        .buttonStyle(PlainButtonStyle())
    }
}

struct SearchResultSelectorButton_Previews: PreviewProvider {
    static var previews: some View {
        HStack {
            SearchResultSelectorButton(
                searchType: .artist,
                action: {},
                selectedType: .constant(.artist)
            )
            SearchResultSelectorButton(
                searchType: .artist,
                action: {},
                selectedType: .constant(.album)
            )
        }
        .padding()
        .background(Color.background)
    }
}
