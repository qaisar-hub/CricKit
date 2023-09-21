////
////  ProfilePhoto.swift
////  CricKit
////
////  Created by Qaisar Raza on 21/09/23.
////

import SwiftUI

struct ProfilePhoto : View {
    @EnvironmentObject var appSettings: AppSettings
    @Binding var showImagePicker: Bool
    @Binding var showFullScreenImage: Bool
    @State private var showAlert = false
    let onUserImageChange: () -> Void
    
    var body: some View {
        NavigationStack {
            ZStack{
                if let image = appSettings.userImage, let userImage = UIImage(data: image)  {
                    Image(uiImage: userImage)
                        .resizable()
                        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width)
                        .toolbar(content: {
                            ToolbarItem(placement: .topBarLeading) {
                                CustomBackButton()
                            }
                            
                            ToolbarItem(placement: .topBarTrailing) {
                                    HStack {
                                        Button(action: {
                                            withAnimation {
                                                showImagePicker.toggle()
                                            }
                                        }) {
                                            Image(systemName: "pencil.circle")
                                                .renderingMode(.template)
                                                .foregroundStyle(.blue)
                                        }
                                        
                                        Button(action: {
                                            showAlert.toggle()
                                        }) {
                                            Image(systemName: "trash.circle")
                                        }
                                    }
                                }
                        })
                        .navigationTitle(Text("Profile Photo"))
                        .navigationBarTitleDisplayMode(.inline)

                } else {
                    ImagePicker(onUserImageChange: onUserImageChange)
                        .ignoresSafeArea()
                }
            }
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("Delete Profile Photo"),
                    message: Text("Are you sure you want to delete your profile photo?"),
                    primaryButton: .cancel(),
                    secondaryButton: .destructive(Text("Delete")) {
                        appSettings.userImage = nil
                        withAnimation{
                            showFullScreenImage.toggle()
                        }
                        onUserImageChange()
                    }
                )
            }
            .sheet(isPresented: $showImagePicker) {
                ImagePicker(onUserImageChange: onUserImageChange)
                    .ignoresSafeArea()
            }
            .navigationBarBackButtonHidden(true)
            .ignoresSafeArea()
        }
    }
}




struct ImagePicker: UIViewControllerRepresentable {
    @Environment(\.presentationMode) private var presentationMode
    @EnvironmentObject var appSettings: AppSettings
    let onUserImageChange: () -> Void
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.sourceType = .photoLibrary
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        var parent: ImagePicker
        
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            DispatchQueue.main.async { [weak self] in
                if let selectedImage = info[.originalImage] as? UIImage {
                    if let data = selectedImage.pngData() {
                        self?.parent.appSettings.userImage = data
                        self?.parent.onUserImageChange()
                    }
                }
            }
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
}



#Preview {
    ProfilePhoto(showImagePicker: .constant(false), showFullScreenImage: .constant(false), onUserImageChange: {})
}
