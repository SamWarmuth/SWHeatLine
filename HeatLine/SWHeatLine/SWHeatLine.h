//
//  SWHeatLine.h
//  HeatLine
//
//  Created by Samuel Warmuth on 3/20/13.
//  Copyright (c) 2013 Sam Warmuth. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
	SWHeatLineTypeFull,
    SWHeatLineTypeGrades,
    SWHeatLineTypeHue
} SWHeatLineType;

@interface SWHeatLine : UIView

@property (nonatomic, strong) NSArray *values;
@property (nonatomic) SWHeatLineType type;

@end
