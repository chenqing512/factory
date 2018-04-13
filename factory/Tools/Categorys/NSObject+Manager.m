//
//  NSObject+Manager.m
//  factory
//
//  Created by Qing Chen on 2018/4/13.
//  Copyright © 2018年 weiguo. All rights reserved.
//

#import "NSObject+Manager.h"

@implementation NSObject (Manager)

-(void)saveMe {
    if ([self conformsToProtocol:@protocol(NSCoding)]) {
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self];
        [[NSUserDefaults standardUserDefaults] setObject:data forKey:NSStringFromClass([self class])];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

+(id)loadSavedData {
    if ([self conformsToProtocol:@protocol(NSCoding)]) {
        NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:NSStringFromClass([self class])];
        if(data){
            id obj = [NSKeyedUnarchiver unarchiveObjectWithData:data];
            return obj;
        }
    }
    
    return nil;
}

@end
