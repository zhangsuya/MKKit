//
//  MKResource.h
//  MKKit
//
//  Created by zhangsuya on 2020/9/29.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKResource : NSObject

+ (UIImage *)imageNamed:(NSString *)name;

+ (UIImage *)imageNamed:(NSString *)name bundleName:(NSString*)bundleName;

+ (NSString *)filePathWithNamed:(NSString *)name;

//cocopods私有库管理图片
//1.创建类 ABCResource继承 MKResource
//2.创建 ABCResource.xcassets
//3.在ABCResource.xcassets中创建ABCResource文件夹
//4.选中ABCResource文件夹右上角开启 Provides Namespace
//5.将使用的图片放到ABCResource文件夹中
//6.使用 ABCResource imageName:@“iconName”
//（暂时没有带图片的团队私有库，方案备用）
@end

NS_ASSUME_NONNULL_END
