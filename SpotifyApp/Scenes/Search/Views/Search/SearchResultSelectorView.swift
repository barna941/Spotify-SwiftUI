import SwiftUI

struct SearchResultSelectorView: View {
    let searchTypes: [SearchModel.SearchType]

    @Binding
    var selectedType: SearchModel.SearchType

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            ScrollViewReader { proxy in
                HStack(spacing: 16) {
                    ForEach(searchTypes, id: \.rawValue) { searchType in
                        SearchResultSelectorButton(
                            searchType: searchType,
                            action: {
                                withAnimation {
                                    proxy.scrollTo(searchType.rawValue, anchor: .trailing)
                                }
                            },
                            selectedType: $selectedType
                        )
                    }
                    .padding([.top, .bottom], 8)
                }
                .padding([.leading, .trailing], 16)
            }
        }
    }
}

struct SearchResultSelectorView_Previews: PreviewProvider {
    static var previews: some View {
        SearchResultSelectorView(searchTypes: SearchModel.SearchType.allCases, selectedType: .constant(.album))
            .background(Color.background)
    }
}
