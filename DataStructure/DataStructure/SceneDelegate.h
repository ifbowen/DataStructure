//
//  SceneDelegate.h
//  DataStructure
//
//  Created by Bowen on 2020/6/15.
//  Copyright © 2020 inke. All rights reserved.
//

#import <UIKit/UIKit.h>

/**

 iOS13之前，
 Appdelegate的职责全权处理App生命周期和UI生命周期；
 
 iOS13之后，
 Appdelegate的职责是：
 1、处理 App 生命周期
 2、新的 Scene Session 生命周期
 
 SceneDelegate的职责是：
 UI生命周期

 */
@interface SceneDelegate : UIResponder <UIWindowSceneDelegate>

@property (strong, nonatomic) UIWindow * window;

@end

