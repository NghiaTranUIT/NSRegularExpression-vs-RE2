//
//  RegexUtils.m
//  WebView
//
//  Created by Nghia Tran on 7/11/20.
//  Copyright © 2020 Nghia Tran. All rights reserved.
//

#import "RegexUtils.h"
#import <re2/re2.h>

@implementation RegexUtils

+(BOOL) regexWithText:(NSString *) text pattern:(NSString *) pattern {
    std::string fullText = std::string([text UTF8String]);
    std::string regexPattern = std::string([pattern UTF8String]);
    RE2 re(regexPattern);
    return RE2::PartialMatch(fullText, re);
}

@end
