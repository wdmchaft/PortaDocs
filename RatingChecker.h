//
//  RatingChecker.h
//  Vasco
//
//  Created by Thiago Deserto on 1/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RatingChecker : NSObject

+(BOOL) askForReview;
+(void) saveCheckInDate;
+(void) finalizar;
@end
