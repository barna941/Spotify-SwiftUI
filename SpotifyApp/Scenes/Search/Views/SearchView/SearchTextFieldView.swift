import SwiftUI

struct SearchTextFieldView: View {
    @Binding
    var searchText: String

    var body: some View {
        ZStack(alignment: .trailing) {
            ZStack(alignment: .leading) {
                TextField("", text: $searchText)
                    .frame(height: 32)
                    .foregroundColor(Color.textPrimary)

                if searchText.isEmpty {
                    Text("Search")
                        .foregroundColor(Color.textPrimary.opacity(0.7))
                }
            }
            .padding([.leading, .trailing], 4)
            .background(
                RoundedRectangle(cornerRadius: 4)
                    .fill(Color.gray.opacity(0.3))
            )

            if !searchText.isEmpty {
                Button(
                    action: {
                        searchText = ""
                    },
                    label: {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(Color.gray)
                    }
                )
                .padding(.trailing, 8)
            }
        }
        .padding(EdgeInsets(top: 4, leading: 16, bottom: 4, trailing: 16))
    }
}

struct SearchTextFieldView_Previews: PreviewProvider {
    static var previews: some View {
        SearchTextFieldView(searchText: .constant(""))
            .background(Color.background)
    }
}

