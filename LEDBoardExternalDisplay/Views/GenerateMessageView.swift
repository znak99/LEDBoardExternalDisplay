//
//  GenerateMessageView.swift
//  LEDBoardExternalDisplay
//
//  Created by SeungWoo Hong on 2023/06/06.
//

import SwiftUI

struct GenerateMessageView: View {
    
    @EnvironmentObject var messageManager: GenerateMessageManager
    @EnvironmentObject var displayManager: DisplayManager
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                VStack {

                    // Use the shorter side of the screen for font size
                    MainHeader(fontSize: geo.size.width < geo.size.height
                           ? geo.size.width : geo.size.height)
                    
                    MessageField(message: $messageManager.message.text)
                    
                    if messageManager.isShowBlankFieldWarnning {
                        BlankFieldWarnning()
                    }
                    
                    if displayManager.isShowUnavailableWarnning {
                        AlreadyDisplayingWarnning()
                    }
                    
                    ExternalDisplayStatusInfo(status: $messageManager.isExternalDisplayConnected)
                    
                    if geo.size.width >= geo.size.height { // Landscape
                        HStack {
                            MessageColorPicker(
                                color: $messageManager.message.fontColor,
                                isShowColorPickerView: $messageManager.isShowColorPicker)
                            
                            Spacer()
                            
                            StartButton(action: {
                                withAnimation {
                                    messageManager.displayMessage(displayManager: displayManager)
                                }
                            }, status: $messageManager.isExternalDisplayConnected)
                        }
                    } else {
                        MessageColorPicker(
                            color: $messageManager.message.fontColor,
                            isShowColorPickerView: $messageManager.isShowColorPicker)
                        Spacer()
                    }
                }
                
                if geo.size.width < geo.size.height { // Portrait
                    VStack {
                        Spacer()
                        StartButton(action: {
                            withAnimation {
                                messageManager.displayMessage(displayManager: displayManager)
                            }
                        }, status: $messageManager.isExternalDisplayConnected)
                        .padding(.bottom)
                    }
                }
                
            }
            .padding(.horizontal)
            .fullScreenCover(isPresented: $messageManager.isLEDBoardStart) {
                InternalLEDBoardView()
            }
            .sheet(isPresented: $messageManager.isShowColorPicker, onDismiss: {
                messageManager.isShowColorPicker = false
            }) {
                ColorPickerView(messageManager: messageManager)
            }
        }
    }
}

struct GenerateMessageView_Previews: PreviewProvider {
    static var previews: some View {
        GenerateMessageView()
    }
}
