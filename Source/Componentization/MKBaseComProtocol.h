//
//  MKBaseComProtocol.h
//  MKKit
//
//  Created by zhangsuya on 2020/9/27.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void (^MKModuleCallbackBlock)(_Nullable id info);

NS_ASSUME_NONNULL_BEGIN
/**
 解耦基础协议
 */
@protocol MKBaseComProtocol <NSObject>


@optional

/**
 当调用getInstanceWithProtocol时调用
 */
+ (instancetype _Nonnull)interfaceCreateInstance;


/**
 返回vc (NSObject有默认实现)
 */
@property (nonatomic, readonly) UIViewController *_Nullable mk_viewController;

/**
 返回view (NSObject有默认实现)
 */
@property (nonatomic, readonly) UIView *_Nullable mk_view;


@end

NS_ASSUME_NONNULL_END
