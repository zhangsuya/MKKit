//
//  MKResource.m
//  MKKit
//
//  Created by zhangsuya on 2020/9/29.
//

#import "MKResource.h"
#import <YYKit/YYKit.h>

@implementation MKResource

+ (YYMemoryCache *)imageCache {
    static YYMemoryCache *cache;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        cache = [YYMemoryCache new];
        cache.shouldRemoveAllObjectsOnMemoryWarning = NO;
        cache.shouldRemoveAllObjectsWhenEnteringBackground = NO;
        cache.name = @"MKResource_ImageCache";
    });
    return cache;
}

+ (UIImage *)imageNamed:(NSString *)name {
    return [self imageNamed:name bundleName:NSStringFromClass(self)];
}

+ (NSBundle *)bundle:(NSString *)bundleName {
    if(bundleName.length==0){
        bundleName = NSStringFromClass(self);
    }
    static NSMutableDictionary *bundleDic;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        bundleDic = [NSMutableDictionary new];
    });
    if(bundleDic[bundleName]==nil){
        NSString *path = [[NSBundle mainBundle] pathForResource:bundleName ofType:@"bundle"];
        bundleDic[bundleName] = [NSBundle bundleWithPath:path];
    }
    NSBundle *bundle = bundleDic[bundleName];
    return bundle;
}


+ (UIImage *)imageNamed:(NSString *)name bundleName:(NSString *)bundleName {
    if (name.length==0) return nil;
    name = [name stringByReplacingOccurrencesOfString:@"@1x.png" withString:@""];
    name = [name stringByReplacingOccurrencesOfString:@"@2x.png" withString:@""];
    name = [name stringByReplacingOccurrencesOfString:@"@3x.png" withString:@""];
    name = [name stringByReplacingOccurrencesOfString:@".png" withString:@""];
    if(bundleName.length==0) return nil;
    bundleName = [bundleName stringByReplacingOccurrencesOfString:@".bundle" withString:@""];
    UIImage *image = [[self imageCache] objectForKey:[self keyWithBundleName:bundleName imageName:name]];
    if (image) return image;
    NSString *ext = name.pathExtension;
    if (ext.length == 0) ext = @"png";
    NSString *path = [[self bundle:bundleName] pathForScaledResource:name ofType:ext];
    
    if (!path)
    {
        image = [UIImage imageNamed:name inBundle:[self bundle:bundleName] compatibleWithTraitCollection:nil];
        if (image) {
            image = [image imageByDecoded];
        }else
        {
            return nil;
        }
    }else{
        image = [UIImage imageWithContentsOfFile:path];
        image = [image imageByDecoded];
    }
    if (!image) return nil;
    [[self imageCache] setObject:image forKey:[self keyWithBundleName:bundleName imageName:name]];
    return image;
}


+ (NSString *)keyWithBundleName:(NSString *)bundleName imageName:(NSString *)imageName {
    if (bundleName==nil || imageName == nil ) {
        return nil;
    }
    return [NSString stringWithFormat:@"%@-%@",bundleName,imageName];
}

+ (NSString *)filePathWithNamed:(NSString *)name {
    if (name.length==0) return nil;
    NSString *path = [[self bundle:NSStringFromClass(self)] pathForScaledResource:name ofType:nil];
    return path;
}


@end
