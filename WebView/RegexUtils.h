//
//  RegexUtils.h
//  WebView
//
//  Created by Nghia Tran on 7/11/20.
//  Copyright © 2020 Nghia Tran. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RegexUtils : NSObject
+(BOOL) regexWithText:(NSString *) text pattern:(NSString *) pattern;
@end

NS_ASSUME_NONNULL_END
