//
//  ProfileView.swift
//  YumeSekai
//
//  Created by Deepanshu Bajaj on 05/05/25.
//

import Common
import Core
import SwiftUI
@_exported import struct Foundation.URL

public struct ProfileView: View {
  @State var scrollOffset: CGFloat
  @Environment(\.openURL) var openURL
  @State private var showTermsSheet: Bool = false
  @State private var showPrivacySheet: Bool = false

  public init(scrollOffset: CGFloat = CGFloat.zero) {
    self.scrollOffset = scrollOffset
  }

  public var body: some View {
    ZStack(alignment: .top) {
      ObservableScrollView(scrollOffset: $scrollOffset, showsIndicators: false) { _ in
        VStack(spacing: Space.large) {
          profile
          YumeDivider()
          aboutSection
        }
        .padding(
          EdgeInsets(
            top: 0,
            leading: Space.none,
            bottom: Space.medium,
            trailing: Space.none)
        )
      }.background(YumeColor.background)

      AppBar(scrollOffset: scrollOffset, label: "profile_title".localized(bundle: .common))
    }
    .sheet(isPresented: $showTermsSheet) {
      TermsOfServiceView()
    }
    .sheet(isPresented: $showPrivacySheet) {
      PrivacyPolicyView()
    }
  }
}

extension ProfileView {
  var profile: some View {
    VStack(spacing: Space.none) {
      profileBackground
      HStack {
        VStack(alignment: .leading, spacing: Space.small) {
          profilePicture

          VStack(alignment: .leading, spacing: Space.tiny) {
            Text("Deepanshu Bajaj")
              .typography(.title2(weight: .bold))
            
            // Clickable GitHub Link
            Button(action: {
                if let link = AppConfig.environment?.gitLink,
                   let url = URL(string: link) {
                    openURL(url)
                }
            }) {
              HStack(spacing: 4) {
                Image(systemName: "link")
                  .foregroundColor(YumeColor.primary)
                Text("github.com/deepanshubajaj")
                  .typography(.caption(color: YumeColor.primary))
              }
            }
          }
        }
        Spacer()
      }
      .padding(.horizontal, 16)
    }
  }

  var profileBackground: some View {
    Rectangle()
      .fill(Formatter.rgbToColor(red: 201, green: 203, blue: 202))
      .frame(height: 100)
  }

  var profilePicture: some View {
    CircleImage(image: Image("ProfilePicture", bundle: .module))
      .frame(width: 80, height: 80)
      .overlay {
        Circle().stroke(.white, lineWidth: 2)
      }
      .offset(y: -40)
      .padding(.bottom, -40)
  }
  
  var aboutSection: some View {
    VStack(alignment: .leading, spacing: Space.medium) {
      Text("About")
        .typography(.title3(weight: .bold))
        .padding(.horizontal, Space.medium)
      
      VStack(spacing: Space.small) {
        aboutItem(
          icon: "info.circle.fill",
          title: "Version",
          detail: "1.0.0"
        )
        
        aboutItem(
          icon: "doc.text.fill",
          title: "Terms of Service",
          detail: "Read our terms and conditions",
          action: {
            showTermsSheet = true
          }
        )
        
        aboutItem(
          icon: "hand.raised.fill",
          title: "Privacy Policy",
          detail: "Read our privacy policy",
          action: {
            showPrivacySheet = true
          }
        )
        
          aboutItem(
            icon: "globe",
            title: "Website",
            detail: "Visit my portfolio website",
            action: {
              if let website = AppConfig.environment?.website,
                 let url = URL(string: website) {
                openURL(url)
              }
            }
          )

      }
      .padding(.horizontal, Space.medium)
    }
  }
  
  func aboutItem(
    icon: String,
    title: String,
    detail: String,
    action: (() -> Void)? = nil
  ) -> some View {
    Button(action: { action?() }) {
      HStack(spacing: Space.medium) {
        Image(systemName: icon)
          .foregroundColor(YumeColor.primary)
          .font(.system(size: 20))
        
        VStack(alignment: .leading, spacing: 2) {
          Text(title)
            .typography(.body(weight: .medium))
          Text(detail)
            .typography(.caption(color: YumeColor.onSurfaceVariant))
        }
        
        Spacer()
        
        if action != nil {
          Image(systemName: "chevron.right")
            .foregroundColor(YumeColor.onSurfaceVariant)
            .font(.system(size: 14))
        }
      }
      .padding(Space.medium)
      .background(YumeColor.surface)
      .cornerRadius(Shape.small)
    }
    .buttonStyle(PlainButtonStyle())
  }
}

struct ProfileView_Previews: PreviewProvider {
  static var previews: some View {
    ProfileView()
  }
}

private struct TermsOfServiceView: View {
  @Environment(\.dismiss) var dismiss
  
  var body: some View {
    NavigationView {
      ScrollView {
        VStack(alignment: .leading, spacing: Space.medium) {
          Text("Terms of Service")
            .typography(.title2(weight: .bold))
            .padding(.bottom, Space.small)
          
          VStack(alignment: .leading, spacing: Space.medium) {
            sectionView(
              title: "1. Acceptance of Terms",
              content: "By accessing and using YumeSekai, you agree to be bound by these Terms of Service."
            )
            
            sectionView(
              title: "2. User Content",
              content: "Users are responsible for the content they post and share through the app."
            )
            
            sectionView(
              title: "3. Privacy",
              content: "Your privacy is important to us. Please review our Privacy Policy to understand how we collect and use your data."
            )
            
            sectionView(
              title: "4. Service Changes",
              content: "We reserve the right to modify or discontinue the service at any time."
            )
          }
        }
        .padding(Space.medium)
      }
      .background(YumeColor.background)
      .navigationBarTitleDisplayMode(.inline)
      .toolbar {
        ToolbarItem(placement: .navigationBarTrailing) {
          Button(action: { dismiss() }) {
            Image(systemName: "xmark.circle.fill")
              .font(.system(size: 22))
              .foregroundColor(YumeColor.primary)
              .padding(.vertical, 8)
          }
        }
      }
    }
  }
  
  private func sectionView(title: String, content: String) -> some View {
    VStack(alignment: .leading, spacing: Space.small) {
      Text(title)
        .typography(.headline(color: YumeColor.primary))
      
      Text(content)
        .typography(.body(color: YumeColor.onSurface))
    }
    .padding(Space.medium)
    .frame(maxWidth: .infinity, alignment: .leading)
    .background(YumeColor.surface)
    .cornerRadius(Shape.small)
  }
}

private struct PrivacyPolicyView: View {
  @Environment(\.dismiss) var dismiss
  
  var body: some View {
    NavigationView {
      ScrollView {
        VStack(alignment: .leading, spacing: Space.medium) {
          Text("Privacy Policy")
            .typography(.title2(weight: .bold))
            .padding(.bottom, Space.small)
          
          VStack(alignment: .leading, spacing: Space.medium) {
            sectionView(
              title: "1. Information We Collect",
              content: "We collect information that you provide directly to us, including your anime preferences, watchlist, and account information to provide you with a personalized experience."
            )
            
            sectionView(
              title: "2. How We Use Your Information",
              content: "We use the collected information to provide, maintain, and improve our services, personalize your experience, and communicate with you about updates and recommendations."
            )
            
            sectionView(
              title: "3. Information Sharing",
              content: "We do not sell or share your personal information with third parties except as necessary to provide our services or as required by law."
            )
            
            sectionView(
              title: "4. Data Security",
              content: "We implement appropriate security measures to protect your personal information from unauthorized access, alteration, or destruction."
            )
            
            sectionView(
              title: "5. Your Rights",
              content: "You have the right to access, correct, or delete your personal information. You can manage your data preferences through your account settings."
            )
            
            sectionView(
              title: "6. App Distribution Restrictions",
              content: """
                The redistribution, sharing, or repackaging of this app is strictly prohibited. \
                You may not distribute, share, modify, or make the app available through any means other than official distribution channels. \
                Any unauthorized distribution or sharing of this app is a violation of our terms and may result in legal action. \
                For any queries, please contact me at
                """,
              link: AppConfig.environment?.gitLink ?? ""
            )
          }
        }
        .padding(Space.medium)
      }
      .background(YumeColor.background)
      .navigationBarTitleDisplayMode(.inline)
      .toolbar {
        ToolbarItem(placement: .navigationBarTrailing) {
          Button(action: { dismiss() }) {
            Image(systemName: "xmark.circle.fill")
              .font(.system(size: 22))
              .foregroundColor(YumeColor.primary)
              .padding(.vertical, 8)
          }
        }
      }
    }
  }
  
  private func sectionView(title: String, content: String, link: String? = nil) -> some View {
    VStack(alignment: .leading, spacing: Space.small) {
      Text(title)
        .typography(.headline(color: YumeColor.primary))
      
      if let link = link {
        SectionContentWithLink(content: content, link: link)
      } else {
        Text(content)
          .typography(.body(color: YumeColor.onSurface))
      }
    }
    .padding(Space.medium)
    .frame(maxWidth: .infinity, alignment: .leading)
    .background(YumeColor.surface)
    .cornerRadius(Shape.small)
  }
}

private struct SectionContentWithLink: View {
  let content: String
  let link: String
  @Environment(\.openURL) private var openURL
  
  var body: some View {
    VStack(alignment: .leading, spacing: 4) {
      Text(content)
        .typography(.body(color: YumeColor.onSurface))
      
      Button(action: {
        if let url = URL(string: link) {
          openURL(url)
        }
      }) {
        Text(link)
          .typography(.body(color: YumeColor.primary))
          .underline()
      }
    }
  }
}

