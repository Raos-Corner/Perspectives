import Foundation
import SwiftUI

struct AppStyle {
    struct Colors {
        struct Surface {
            static var background: Color {
                .black
            }
            
            static var foreground: Color {
                .white
            }
        }
        
        struct Text {
            static var light: Color {
                .white
            }
            
            static var dark: Color {
                .black
            }
        }
    }
}

public extension CGFloat {
    static var layer6: CGFloat { 32 }
    static var layer5: CGFloat { 24 }
    static var layer4: CGFloat { 16 }
    static var layer3: CGFloat { 12 }
    static var layer2: CGFloat { 8 }
    static var layer1: CGFloat { 4 }
}
