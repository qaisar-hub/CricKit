//
//  ProfileCard.swift
//  CricKit
//
//  Created by Qaisar Raza on 18/08/23.
//

import SwiftUI

struct ProfileCard: View {
    @State private var showImagePicker: Bool = false
    @State private var selectedImage: UIImage? = nil
    @EnvironmentObject var appSettings: AppSettings
    
    var initials: String
    var fullName: String
    var emailID: String
    
    var body: some View {
        HStack(spacing: 20) {
            if let userImage = selectedImage {
                Image(uiImage: userImage)
                    .resizable()
                    .frame(width: 60, height: 60)
                    .clipShape(Circle())
                    .shadow(radius: 5)
                    .overlay(
                        Image(systemName: "camera")
                            .font(.headline)
                            .foregroundColor(ColorManager.appPrimaryColor())
                            .offset(x: 25, y: 25)
                            .onTapGesture {
                                showImagePicker.toggle()
                            }
                    )
            } else {
                Text(initials)
                    .font(.title)
                    .foregroundColor(Color.white)
                    .frame(width: 60, height: 60)
                    .background(Color(.systemGray3))
                    .clipShape(Circle())
                    .shadow(radius: 5)
                    .overlay(
                        Image(systemName: "camera")
                            .font(.headline)
                            .foregroundColor(ColorManager.appPrimaryColor())
                            .offset(x: 25, y: 25)
                            .onTapGesture {
                                showImagePicker.toggle()
                            }
                    )
            }
            
            VStack(alignment: .leading) {
                Text(fullName)
                    .font(.title)
                    .foregroundColor(ColorManager.appTextColor(colorScheme: appSettings.isDarkMode ? .dark : .light))
                Text(emailID)
                    .foregroundColor(ColorManager.appTextColor(colorScheme: appSettings.isDarkMode ? .dark : .light))
            }
        }
        .sheet(isPresented: $showImagePicker) {
            ImagePicker(selectedImage: $selectedImage)
        }
    }
}

struct ProfileCard_Previews: PreviewProvider {
    static var previews: some View {
        ProfileCard(initials: "VK", fullName: "Virat Kohli", emailID: "virat_k@gmail.com")
            .environmentObject(AppSettings())
    }
}


struct ImagePicker: UIViewControllerRepresentable {
    @Binding var selectedImage: UIImage?
    @Environment(\.presentationMode) private var presentationMode

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.sourceType = .photoLibrary // You can change this to .camera if needed
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
            if let selectedImage = info[.originalImage] as? UIImage {
                parent.selectedImage = selectedImage
            }
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
}

