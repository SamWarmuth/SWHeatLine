//
//  SWViewController.m
//  HeatLine
//
//  Created by Samuel Warmuth on 3/20/13.
//  Copyright (c) 2013 Sam Warmuth. All rights reserved.
//

#import "SWViewController.h"
#import "SWHeatLine.h"

@interface SWViewController ()
@property (nonatomic, weak) IBOutlet SWHeatLine *heatLine;
@end

@implementation SWViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.heatLine.values = @[@0,@10,@20,@70,@40,@50,@60,@70,@80,@90,@100,@100,@80,@60,@40,@60,@80,@80,@80,@100,@100];
    
    //Uncomment to switch color mapping style.
    //self.heatLine.type = SWHeatLineTypeFull;
}


@end
