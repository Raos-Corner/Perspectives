import Granite
import SwiftUI
import WebKit

extension Settings: View {
    var aboutPageLinkString: String {
        "https://stoicnyc.notion.site/Stoic-b3fd36482708450c9abc562acd33b139"
    }
    
    public var view: some View {
        ZStack {
            VStack {
                HStack {
                    GraniteText("about",
                                .headline)
                    .padding(.leading, Brand.Padding.medium)
                    
                    Spacer()
                }.padding(.top, Brand.Padding.medium)
                
                VStack {
                    GraniteWebView(remote: $action,
                                   state: $webState,
                                   highlightedText: .constant(""),
                                   restrictedPages: ["apple.com"],
                                   htmlInState: true)
                    .clipShape(
                        RoundedRectangle(cornerRadius: 6)
                            .offset(x: 0, y: 62)
                    )
                    .padding(.top, -62)
                    .cornerRadius(6)
                    .padding(.bottom, 8)
                    
                    
                    Spacer()
                    
                    HStack {
                        Image("logo_granite")
                            .resizable()
                            .frame(width: 20, height: 20)
                        Text("Built with ")
                            .font(Fonts.live(.subheadline, .bold))
                        + Text("Granite")
                            .font(Fonts.live(.headline, .bold))
                            .foregroundColor(.accentColor)
                        
                        Spacer()
                    }
                    .frame(height: 20)
                    .onTapGesture {
                        if let url = URL(string: "https://www.github.com/pexavc/granite") {
                            openURL(url)
                        }
                    }
                    
                    HStack(spacing: 4) {
                        Text("Privacy Policy")
                            .font(Fonts.live(.subheadline, .regular))
                            .foregroundColor(.accentColor)
                            .onTapGesture {
                                if let url = URL(string: "https://stoic.nyc/bullish/privacy") {
                                    openURL(url)
                                }
                            }
                        
                        Text("and")
                            .font(Fonts.live(.subheadline, .regular))
                            .foregroundColor(Brand.Colors.white)
                        
                        
                        Text("Terms of Use")
                            .font(Fonts.live(.subheadline, .regular))
                            .foregroundColor(.accentColor)
                            .onTapGesture {
                                if let url = URL(string: "https://stoic.nyc/bullish/terms") {
                                    openURL(url)
                                }
                            }
                        
                        Spacer()
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.bottom, 8)
                    
                    HStack {
                        Text("Copyright Stoic Collective, LLC. \u{00A9} \(Calendar.current.component(.year, from: Date.now).asString.replacingOccurrences(of: ",", with: ""))")
                            .font(Fonts.live(.caption2, .regular))
                        
                        Spacer()
                    }
                    
                    
                    Spacer()
                }
                .padding(.horizontal, Brand.Padding.medium)
            }
        }
        .padding(.bottom, .layer1)
        .onAppear {
            if let url = URL(string: aboutPageLinkString) {
                action = .load(URLRequest(url: url))
            }
        }
    }
}
