import SwiftUI

struct SearchView<Router: SearchRouting, ViewModel: SearchViewModelProtocol>: View where Router.Route == SearchRoute {
    let router: Router

    @StateObject
    var viewModel: ViewModel

    @State
    private var selectedResultType: SearchModel.SearchType = .artist

    private let topInset: CGFloat = 104

    var body: some View {
        NavigationView {
            ZStack(alignment: .top) {
                Color.background.ignoresSafeArea()

                SearchResultsView(
                    topInset: topInset,
                    selectedResultType: $selectedResultType,
                    searchResults: Binding(get: { viewModel.searchResults })
                )

                VisualEffectView(effect: UIBlurEffect(style: .dark))
                    .ignoresSafeArea()
                    .frame(height: topInset)

                VStack {
                    SearchTextFieldView(searchText: $viewModel.searchText)
                    SearchResultSelectorView(selectedType: $selectedResultType)
                }
            }
            .navigationBarHidden(true)
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(
            router: SearchRouter(),
            viewModel: SearchViewModel(interactor: DependencyProvider.resolver.resolve(SearchInteractorProtocol.self)!)
        )
    }
}
