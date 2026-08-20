import SwiftUI

struct NewsDetailView: View {
    
    let article: NewsArticle
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                
                articleImage
                
                Text(article.title)
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundStyle(.primary)
                
                HStack(spacing: 8) {
                    
                    Text(article.sourceName)
                        .fontWeight(.semibold)
                        .lineLimit(1)
                    
                    Spacer()
                    
                    Text(
                        article.publishedAt,
                        style: .relative
                    )
                    .lineLimit(1)
                }
                .font(.caption)
                .foregroundStyle(.secondary)
                
                if let description = article.description {
                    Text(description)
                        .font(.body)
                        .foregroundStyle(.secondary)
                }
                
                if let url = article.url {
                    Link(destination: url) {
                        Label(
                            "Read Full Article",
                            systemImage: "arrow.up.right.square"
                        )
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 4)
                    }
                    .buttonStyle(.borderedProminent)
                    .controlSize(.large)
                    .padding(.top, 4)
                }
            }
            .padding(16)
            .background {
                RoundedRectangle(cornerRadius: 18)
                    .fill(Color(.secondarySystemGroupedBackground))
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
        }
        .background(
            Color(.systemGroupedBackground)
        )
        .navigationTitle("Article")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    @ViewBuilder
    private var articleImage: some View {
        if let imageURL = article.imageURL {
            AsyncImage(url: imageURL) { phase in
                switch phase {
                case .empty:
                    imagePlaceholder
                    
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: .infinity)
                        .clipShape(
                            RoundedRectangle(cornerRadius: 14)
                        )
                    
                case .failure:
                    imagePlaceholder
                    
                @unknown default:
                    imagePlaceholder
                }
            }
            .frame(maxWidth: .infinity)
            
        } else {
            imagePlaceholder
        }
    }
    
    private var imagePlaceholder: some View {
        RoundedRectangle(cornerRadius: 14)
            .fill(Color(.tertiarySystemFill))
            .frame(maxWidth: .infinity)
            .frame(height: 220)
            .overlay {
                Image(systemName: "newspaper.fill")
                    .font(.system(size: 38))
                    .foregroundStyle(.secondary)
            }
    }
}
