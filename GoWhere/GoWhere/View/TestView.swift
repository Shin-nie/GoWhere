import SwiftUI
let scenes = UIApplication.shared.connectedScenes
let windowScene = scenes.first as? UIWindowScene
let window = windowScene?.windows.first
let safeAreaTop = window?.safeAreaInsets.top
struct TestView: View {
    @State private var selection_seo: String = "For You"
    var body: some View {
        TabView {
            Group {
                Page()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
                VStack {
                    Text("Insert Discover content here.")
                }
                .tabItem {
                    Label("Discover", systemImage: "star.fill")
                }
                VStack {
                    Text("Insert Passport content here.")
                }
                .tabItem {
                    Label("Passport", systemImage: "person.text.rectangle.fill")
                }
            }
            .toolbarBackground(.ultraThickMaterial, for: .tabBar)
            .toolbarBackground(.visible, for: .tabBar)
        }
        .tint(Color(hex: 0xff7733))
        // MARK: SwiftUI TabView does not support changing tab symbols when selected
        .ignoresSafeArea(.all, edges: [.bottom])
        }
        public struct TextField1: View {
            @State private var input: String = ""
            var body: some View {
                TextField("", text: $input, prompt: Text("Search").foregroundStyle(Color(hex: 0x3c3c43, alpha: 0.6)))
                  .font(.system(size: 17))
                  .foregroundStyle(.black)
                  .offset(x: -6)
                  .padding(8)
            }
        }
    // MARK: additional structs
    struct Page: View {
        @State var geo1: CGSize = .zero
        @State var geo: CGSize = .zero
        @State private var selection_seo: String = "For You"
        var body: some View {
            VStack(alignment: .leading) {
                ScrollView(.vertical, showsIndicators: false) {
                    VStack (spacing: 12) {
                        HStack(alignment: .top, spacing:8) {
                            HStack(spacing:10) {
                                VStack(alignment: .leading, spacing:8) {
                                    AsyncImage(url: URL(string: "https://firebasestorage.googleapis.com/v0/b/play-app-gen2.appspot.com/o/teams%2F7LUOWAdr8XFiuWll33T5%2FsharedAssets%2F3d20d44dd04380OLuSd-raw.png?alt=media&token=be129da4-be23-48d8-98ba-adcc3dfa471c")) { image in
                                        image.resizable()
                                          .aspectRatio(contentMode: .fill)
                                          .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                                          .clipped()
                                    } placeholder: {
                                        ProgressView()
                                    }
                                }
                                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
                                .background(alignment: .bottom) {
                                    AsyncImage(url: URL(string: "https://firebasestorage.googleapis.com/v0/b/play-app-gen2.appspot.com/o/teams%2F7LUOWAdr8XFiuWll33T5%2FsharedAssets%2F3d20d44dd04380ZUhdM-raw.png?alt=media&token=c690e916-01dc-4c14-83c4-c5f28046e1e5")) { image in
                                        image.resizable()
                                          .scaledToFit()
                                          .aspectRatio(contentMode: .fit)
                                          .frame(width: 361, height: 104)
                                          .background(.black.opacity(0))
                                    } placeholder: {
                                        ProgressView()
                                    }
                                }
                            }
                            .frame(width: 398, height: 444, alignment: .leading)
                            .clipped()
                            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                            .shadow(color: .black.opacity(0.09), radius: 12, x: 0, y: 2)
                            HStack(spacing:10) {
                                VStack(alignment: .leading, spacing:8) {
                                    AsyncImage(url: URL(string: "https://images.unsplash.com/photo-1480996408299-fc0e830b5db1?ixid=M3w4OTk0OHwwfDF8c2VhcmNofDh8fHZpZXRuYW18ZW58MHx8fHwxNzIwNjE1NTk4fDA&ixlib=rb-4.0.3")) { image in
                                        image.resizable()
                                          .aspectRatio(contentMode: .fill)
                                          .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                                          .clipped()
                                    } placeholder: {
                                        ProgressView()
                                    }
                                }
                                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
                                .background(alignment: .bottom) {
                                    AsyncImage(url: URL(string: "https://firebasestorage.googleapis.com/v0/b/play-app-gen2.appspot.com/o/teams%2F7LUOWAdr8XFiuWll33T5%2FsharedAssets%2F3d20e8c0e3b5004swNg-raw.png?alt=media&token=3564c375-680f-4255-a2a0-177dd94abb86")) { image in
                                        image.resizable()
                                          .scaledToFit()
                                          .aspectRatio(contentMode: .fit)
                                          .frame(width: 361, height: 104)
                                          .background(.black.opacity(0))
                                    } placeholder: {
                                        ProgressView()
                                    }
                                }
                            }
                            .frame(width: 398, height: 444, alignment: .leading)
                            .clipped()
                            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                            .shadow(color: .black.opacity(0.09), radius: 12, x: 0, y: 2)
                            .scaleEffect(0.9)
                            .projectionEffect(transformValue(translateZ: -60, rotationY: -30, scaleX: 0, scaleY: 0))
                            HStack(spacing:10) {
                                VStack(alignment: .leading, spacing:8) {
                                    AsyncImage(url: URL(string: "https://images.unsplash.com/photo-1555979864-7a8f9b4fddf8?ixid=M3w4OTk0OHwwfDF8c2VhcmNofDExfHx2aWV0bmFtfGVufDB8fHx8MTcyMDYxNTU5OHww&ixlib=rb-4.0.3")) { image in
                                        image.resizable()
                                          .aspectRatio(contentMode: .fill)
                                          .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                                          .clipped()
                                    } placeholder: {
                                        ProgressView()
                                    }
                                }
                                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
                                .background(alignment: .bottom) {
                                    AsyncImage(url: URL(string: "https://firebasestorage.googleapis.com/v0/b/play-app-gen2.appspot.com/o/teams%2F7LUOWAdr8XFiuWll33T5%2FsharedAssets%2F3d20e935b6ef00J40f5-raw.png?alt=media&token=10ed12d9-7579-4d7a-b725-a2563e06c2e2")) { image in
                                        image.resizable()
                                          .scaledToFit()
                                          .aspectRatio(contentMode: .fit)
                                          .frame(width: 361, height: 104)
                                          .background(.black.opacity(0))
                                    } placeholder: {
                                        ProgressView()
                                    }
                                }
                            }
                            .frame(width: 398, height: 444, alignment: .leading)
                            .clipped()
                            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                            .shadow(color: .black.opacity(0.09), radius: 12, x: 0, y: 2)
                            .scaleEffect(0.9)
                            .projectionEffect(transformValue(translateZ: -60, rotationY: -30, scaleX: 0, scaleY: 0))
                        }
                        .frame(maxWidth: .infinity, alignment: .topLeading)
                        .saveSize(in: $geo)
                        ZStack() {}
                        .frame(maxWidth: .infinity, alignment: .topLeading)
                        .frame(height: 24, alignment: .topLeading)
                        .padding(.top, 4)
                        .background(alignment: .topLeading) {
                            ZStack() {}
                            .frame(width: 8, height: 8)
                            .background(.black)
                            .cornerRadius(50)
                            .offset(x: 160, y: 8)
                        }
                        .background(alignment: .topLeading) {
                            ZStack() {}
                            .frame(width: 8, height: 8)
                            .background(.black)
                            .cornerRadius(50).opacity(0.30000001192092896)
                            .offset(x: 176, y: 8)
                        }
                        .background(alignment: .topLeading) {
                            ZStack() {}
                            .frame(width: 8, height: 8)
                            .background(.black)
                            .cornerRadius(50).opacity(0.30000001192092896)
                            .offset(x: 192, y: 8)
                        }
                        VStack(alignment: .leading, spacing:12) {
                            Picker("", selection: $selection_seo) {
                                ForEach(["For You","Updated","Saved"], id: \.self) {
                                    Text($0)
                                }
                            }
                            .pickerStyle(SegmentedPickerStyle())
                            .frame(maxWidth: .infinity)
                            HStack(alignment: .top, spacing:8) {
                                VStack(alignment: .leading, spacing:8) {
                                    ScrollView(.vertical, showsIndicators: true) {
                                        HStack(spacing:16) {
                                            ZStack() {}
                                            .frame(width: 64, height: 64, alignment: .topLeading)
                                            .background(alignment: .topLeading) {
                                                AsyncImage(url: URL(string: "https://firebasestorage.googleapis.com/v0/b/play-app-gen2.appspot.com/o/teams%2F7LUOWAdr8XFiuWll33T5%2FsharedAssets%2F3d20d44dd04380ut1N8-raw.png?alt=media&token=7ad76351-9e40-47fb-bc96-31b69d7983c9")) { image in
                                                    image.resizable()
                                                      .aspectRatio(contentMode: .fill)
                                                      .frame(width: 64, height: 64)
                                                      .clipped()
                                                } placeholder: {
                                                    ProgressView()
                                                }
                                            }
                                            .background(Color(hex: 0xd9d9d9))
                                            .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                                            VStack(alignment: .leading, spacing:6) {}
                                            .fixedSize(horizontal: true, vertical: false)
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                        }
                                        .padding(16)
                                    }
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .frame(height: 110, alignment: .leading)
                                    .background(Color(hex: 0xebebeb))
                                    .clipped()
                                    .cornerRadius(16)
                                    ScrollView(.vertical, showsIndicators: true) {
                                        HStack(spacing:16) {
                                            ZStack() {}
                                            .frame(width: 64, height: 64, alignment: .topLeading)
                                            .background(alignment: .topLeading) {
                                                AsyncImage(url: URL(string: "https://firebasestorage.googleapis.com/v0/b/play-app-gen2.appspot.com/o/teams%2F7LUOWAdr8XFiuWll33T5%2FsharedAssets%2F3d20eb7152b880hcMr0-raw.png?alt=media&token=38392a86-5105-4441-b3c0-ce6f9243e372")) { image in
                                                    image.resizable()
                                                      .aspectRatio(contentMode: .fill)
                                                      .frame(width: 64, height: 64)
                                                      .clipped()
                                                } placeholder: {
                                                    ProgressView()
                                                }
                                            }
                                            .background(Color(hex: 0xd9d9d9))
                                            .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                                            VStack(alignment: .leading, spacing:6) {}
                                            .fixedSize(horizontal: true, vertical: false)
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                        }
                                        .padding(16)
                                    }
                                    .frame(width: 361, height: 110, alignment: .leading)
                                    .background(Color(hex: 0xebebeb))
                                    .clipped()
                                    .cornerRadius(16)
                                    ScrollView(.vertical, showsIndicators: true) {
                                        HStack(spacing:16) {
                                            ZStack() {}
                                            .frame(width: 64, height: 64, alignment: .topLeading)
                                            .background(alignment: .topLeading) {
                                                AsyncImage(url: URL(string: "https://firebasestorage.googleapis.com/v0/b/play-app-gen2.appspot.com/o/teams%2F7LUOWAdr8XFiuWll33T5%2FsharedAssets%2F3d20eba959fb80OBmWj-raw.png?alt=media&token=96ac9884-f211-4af3-9049-6876d67e4550")) { image in
                                                    image.resizable()
                                                      .aspectRatio(contentMode: .fill)
                                                      .frame(width: 64, height: 64)
                                                      .clipped()
                                                } placeholder: {
                                                    ProgressView()
                                                }
                                            }
                                            .background(Color(hex: 0xd9d9d9))
                                            .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                                            VStack(alignment: .leading, spacing:6) {}
                                            .fixedSize(horizontal: true, vertical: false)
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                        }
                                        .padding(16)
                                    }
                                    .frame(width: 361, height: 110, alignment: .leading)
                                    .background(Color(hex: 0xebebeb))
                                    .clipped()
                                    .cornerRadius(16)
                                }
                                .fixedSize(horizontal: true, vertical: false)
                                .frame(width: 398, alignment: .topLeading)
                                VStack(alignment: .leading, spacing:8) {
                                    ScrollView(.vertical, showsIndicators: true) {
                                        HStack(spacing:16) {
                                            ZStack() {}
                                            .frame(width: 64, height: 64, alignment: .topLeading)
                                            .background(alignment: .topLeading) {
                                                AsyncImage(url: URL(string: "https://firebasestorage.googleapis.com/v0/b/play-app-gen2.appspot.com/o/teams%2F7LUOWAdr8XFiuWll33T5%2FsharedAssets%2F3d20ebfd64e000CzpFE-raw.png?alt=media&token=02a9c223-b236-4d86-914f-9a7f8caa1121")) { image in
                                                    image.resizable()
                                                      .aspectRatio(contentMode: .fill)
                                                      .frame(width: 64, height: 64)
                                                      .clipped()
                                                } placeholder: {
                                                    ProgressView()
                                                }
                                            }
                                            .background(Color(hex: 0xd9d9d9))
                                            .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                                            VStack(alignment: .leading, spacing:6) {}
                                            .fixedSize(horizontal: true, vertical: false)
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                        }
                                        .padding(16)
                                    }
                                    .frame(width: 361, height: 110, alignment: .leading)
                                    .background(Color(hex: 0xebebeb))
                                    .clipped()
                                    .cornerRadius(16)
                                    ScrollView(.vertical, showsIndicators: true) {
                                        HStack(spacing:16) {
                                            ZStack() {}
                                            .frame(width: 64, height: 64, alignment: .topLeading)
                                            .background(alignment: .topLeading) {
                                                AsyncImage(url: URL(string: "https://firebasestorage.googleapis.com/v0/b/play-app-gen2.appspot.com/o/teams%2F7LUOWAdr8XFiuWll33T5%2FsharedAssets%2F3d20ec30a76f00xBQ5P-raw.png?alt=media&token=f8d11d50-bbc2-4b13-b1ed-b8484e0f76e9")) { image in
                                                    image.resizable()
                                                      .aspectRatio(contentMode: .fill)
                                                      .frame(width: 64, height: 64)
                                                      .clipped()
                                                } placeholder: {
                                                    ProgressView()
                                                }
                                            }
                                            .background(Color(hex: 0xd9d9d9))
                                            .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                                            VStack(alignment: .leading, spacing:6) {}
                                            .fixedSize(horizontal: true, vertical: false)
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                        }
                                        .padding(16)
                                    }
                                    .frame(width: 361, height: 110, alignment: .leading)
                                    .background(Color(hex: 0xebebeb))
                                    .clipped()
                                    .cornerRadius(16)
                                }
                                .fixedSize(horizontal: true, vertical: false)
                                .frame(width: 398, alignment: .topLeading)
                                VStack(alignment: .leading, spacing:8) {
                                    ScrollView(.vertical, showsIndicators: true) {
                                        HStack(spacing:16) {
                                            ZStack() {}
                                            .frame(width: 64, height: 64, alignment: .topLeading)
                                            .background(alignment: .topLeading) {
                                                AsyncImage(url: URL(string: "https://firebasestorage.googleapis.com/v0/b/play-app-gen2.appspot.com/o/teams%2F7LUOWAdr8XFiuWll33T5%2FsharedAssets%2F3d20ec664c5800TkLR5-raw.png?alt=media&token=c10c5f90-52bd-4692-b0e7-6570dcb66580")) { image in
                                                    image.resizable()
                                                      .aspectRatio(contentMode: .fill)
                                                      .frame(width: 64, height: 64)
                                                      .clipped()
                                                } placeholder: {
                                                    ProgressView()
                                                }
                                            }
                                            .background(Color(hex: 0xd9d9d9))
                                            .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                                            VStack(alignment: .leading, spacing:6) {}
                                            .fixedSize(horizontal: true, vertical: false)
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                        }
                                        .padding(16)
                                    }
                                    .frame(width: 361, height: 110, alignment: .leading)
                                    .background(Color(hex: 0xebebeb))
                                    .clipped()
                                    .cornerRadius(16)
                                }
                                .fixedSize(horizontal: true, vertical: false)
                                .frame(width: 398, alignment: .topLeading)
                            }
                            .fixedSize(horizontal: false, vertical: true)
                            .frame(maxWidth: .infinity, alignment: .topLeading)
                            .saveSize(in: $geo1)
                        }
                        .padding(.top, 4)
                        .fixedSize(horizontal: true, vertical: false)
                        .frame(maxWidth: .infinity, alignment: .topLeading)
                    }
                    .padding([.horizontal, .bottom], 16)
                    .padding(.top, 120)
                }
                .frame(minWidth: UIScreen.main.bounds.width, maxHeight: UIScreen.main.bounds.height, alignment: .topLeading)
                .background(Color(hex: 0xf3f3f3).ignoresSafeArea())
            }
            .frame(maxWidth: UIScreen.main.bounds.width, alignment: .topLeading)
            .overlay(
            VStack(alignment: .leading, spacing:6) {
                HStack(spacing:10) {
                    HStack(spacing:16) {}
                    .fixedSize(horizontal: false, vertical: true)
                }
                .padding(.horizontal, 16)
                .padding(.top, 3)
                .padding(.bottom, 8)
                .fixedSize(horizontal: false, vertical: true)
                .frame(maxWidth: .infinity, alignment: .center)
                HStack(spacing:10) {
                    HStack(spacing:0) {
                        TextField1()
                    }
                    .padding(.vertical, 7)
                    .padding(.horizontal, 8)
                    .fixedSize(horizontal: false, vertical: true)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color(hex: 0x787880, alpha: 0.12))
                    .clipped()
                    .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                }
                .padding(.horizontal, 16)
                .padding(.top, 3)
                .padding(.bottom, 8)
                .fixedSize(horizontal: false, vertical: true)
                .frame(maxWidth: .infinity, alignment: .center)
            }
            .padding(.top, safeAreaTop)
            .fixedSize(horizontal: true, vertical: false)
            .frame(maxWidth: .infinity, alignment: .topLeading)
            .background(Color(hex: 0xf3f3f3))
            , alignment: .top)
        }
    }
}
extension Color {
    init(hex: Int, alpha: Double = 1.0) {
        let red = Double((hex & 0xff0000) >> 16) / 255.0
        let green = Double((hex & 0xff00) >> 8) / 255.0
        let blue = Double((hex & 0xff) >> 0) / 255.0
        self.init(.sRGB, red: red, green: green, blue: blue, opacity: alpha)
    }
}
func transformValue(translateX: CGFloat = 0, translateY: CGFloat = 0, translateZ: CGFloat = 0, rotationX: CGFloat = 0, rotationY: CGFloat = 0, rotationZ: CGFloat = 0, perspective: CGFloat = 500, scaleX: CGFloat = 1, scaleY: CGFloat = 1) -> ProjectionTransform {
    func toRadians(_ value: CGFloat) -> CGFloat {
        return value * .pi / 180
    }
    var transform = CATransform3DIdentity
    transform.m34 = -1 / perspective
    transform = CATransform3DTranslate(transform, translateX, translateY, translateZ)
    transform = CATransform3DScale(transform, scaleX, scaleY, 1)
    transform = CATransform3DRotate(transform, toRadians(rotationX), 1, 0, 0)
    transform = CATransform3DRotate(transform, toRadians(rotationY), 0, 1, 0)
    transform = CATransform3DRotate(transform, toRadians(rotationZ), 0, 0, 1)
    return ProjectionTransform(transform)
}
// MARK: Allows for percentage based layouts
struct SizeCalculator: ViewModifier {
    @Binding var size: CGSize
    func body(content: Content) -> some View {
        content.background(
            GeometryReader { proxy in
                Color.clear
                .onAppear { size = proxy.size }
            }
        )
    }
}
extension View {
    func saveSize(in size: Binding<CGSize>) -> some View {
        modifier(SizeCalculator(size: size))
    }
}
#Preview {
    TestView()
}
    

