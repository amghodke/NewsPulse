//
//  NewsRowView.swift
//  NewsPulse
//
//  Created by Amitkumar on 19/08/26.
//
import SwiftUI

struct NewsRowView: View {
    
    let article: NewsArticle
    
    var body: some View {
        NavigationLink {
            NewsDetailView(article: article)
        } label: {
            VStack(alignment: .leading, spacing: 12) {
                
                articleImage
                
                Text(article.title)
                    .font(.headline)
                    .fontWeight(.semibold)
                    .lineLimit(3)
                    .foregroundStyle(.primary)
                
                if let description = article.description {
                    Text(description)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                        .lineLimit(2)
                }
                
                HStack(spacing: 8) {
                    Text(article.sourceName)
                        .fontWeight(.medium)
                        .lineLimit(1)
                    
                    Spacer()
                    
                    Text(article.publishedAt, style: .relative)
                        .lineLimit(1)
                }
                .font(.caption)
                .foregroundStyle(.secondary)
            }
            .padding(12)
            .background {
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color(.secondarySystemGroupedBackground))
            }
        }
        .buttonStyle(.plain)
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
                        .scaledToFill()
                    
                case .failure:
                    imagePlaceholder
                    
                @unknown default:
                    imagePlaceholder
                }
            }
            .frame(maxWidth: .infinity)
            .frame(height: 200)
            .clipped()
            .clipShape(
                RoundedRectangle(cornerRadius: 12)
            )
            
        } else {
            imagePlaceholder
        }
    }
    
    private var imagePlaceholder: some View {
        RoundedRectangle(cornerRadius: 12)
            .fill(Color(.tertiarySystemFill))
            .frame(maxWidth: .infinity)
            .frame(height: 200)
            .overlay {
                Image(systemName: "newspaper.fill")
                    .font(.system(size: 36))
                    .foregroundStyle(.secondary)
            }
    }
}

/*
 import SwiftUI

struct NewsRowView: View {
    
    let article: NewsArticle
    
    var body: some View {
        NavigationLink {
            NewsDetailView(article: article)
        } label: {
            VStack(alignment: .leading, spacing: 12) {
                
                articleImage
                
                Text(article.title)
                    .font(.headline)
                    .fontWeight(.semibold)
                    .lineLimit(3)
                
                if let description = article.description {
                    Text(description)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                        .lineLimit(3)
                }
                
                HStack {
                    Text(article.sourceName)
                        .fontWeight(.medium)
                    
                    Spacer()
                    
                    Text(article.publishedAt, style: .relative)
                }
                .font(.caption)
                .foregroundStyle(.secondary)
            }
            .padding(.vertical, 8)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color(.secondarySystemGroupedBackground))
            )
            
        }
        .buttonStyle(.plain)
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
                        .scaledToFill()
                    
                case .failure:
                    imagePlaceholder
                    
                @unknown default:
                    imagePlaceholder
                }
            }
            .frame(maxWidth: .infinity)
            .frame(height: 200)
            .clipShape(
                RoundedRectangle(cornerRadius: 12)
            )
        } else {
            imagePlaceholder
        }
    }
    
    private var imagePlaceholder: some View {
        RoundedRectangle(cornerRadius: 12)
            .fill(.quaternary)
            .frame(maxWidth: .infinity)
            .frame(height: 200)
            .overlay {
                Image(systemName: "newspaper")
                    .font(.largeTitle)
                    .foregroundStyle(.secondary)
            }
    }
}
*/
