//
//  ImagePickerViewPreview.swift
//  Little Lemon
//
//  Created by Thwin Htoo Aung on 19/4/26.
//

import SwiftUI
import Photos
import PhotosUI

struct ImagePickerViewPreview: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct ImagePickerView: UIViewControllerRepresentable {
    
    var onComplete: (UIImage?) -> Void = { _ in }
    
    class PickerCoordinator: NSObject, PHPickerViewControllerDelegate {
        
        var onComplete: (UIImage?) -> Void = { _ in }
        
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            
            guard let result = results.first else {
                return picker.dismiss(animated: true) {
                    self.onComplete(nil)
                }
            }
                
            let provider = result.itemProvider
            if provider.canLoadObject(ofClass: UIImage.self) {
                provider.loadObject(ofClass: UIImage.self) { [onComplete] (image, error) in
//                    print(image, error)
                    DispatchQueue.main.async {
                        if let selectedImage = image as? UIImage {
                            onComplete(selectedImage)
                        }
                    }
                }
            }
            picker.dismiss(animated: true)
        }
    }
    
    func makeCoordinator() -> PickerCoordinator {
        let coordinator = PickerCoordinator()
        coordinator.onComplete = onComplete
        return coordinator
    }
    
    func makeUIViewController(context: Context) -> PHPickerViewController {
        var config = PHPickerConfiguration()
        config.filter = .images
        config.selectionLimit = 1
        
        let controller = PHPickerViewController(configuration: config)
        controller.delegate = context.coordinator
        return controller
    }
    
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {
        
    }
    
}

#Preview {
    ImagePickerViewPreview()
}
