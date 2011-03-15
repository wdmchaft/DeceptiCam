//
//  DeceptiCamViewController.m
//  DeceptiCam
//
//  Created by Lars Anderson on 2/19/11.
//  Copyright 2011 Drink & Apple. All rights reserved.
//

#import "DeceptiCamViewController.h"
#import "LACallButtonContainer.h"
#import <QuartzCore/QuartzCore.h>



@implementation DeceptiCamViewController

#if !TARGET_IPHONE_SIMULATOR
@synthesize cameraManager = _cameraManager;
#endif
@synthesize buttonContainer = _buttonContainer;
@synthesize topLeft = _topLeft;
@synthesize topCenter = _topCenter;
@synthesize topRight = _topRight;
@synthesize bottomLeft = _bottomLeft;
@synthesize bottomCenter = _bottomCenter;
@synthesize bottomRight = _bottomRight;

/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad{
    [super viewDidLoad];
#if !TARGET_IPHONE_SIMULATOR
	_cameraManager = [[LACamManager alloc] init];
	[[self cameraManager] createNewSessionWithVideo:NO];
#endif
	
	[[UIDevice currentDevice] setProximityMonitoringEnabled:YES];
	
	[[NSNotificationCenter defaultCenter] addObserver:self 
											 selector:@selector(handleProximitySensorChange) 
												 name:@"UIDeviceProximityStateDidChangeNotification"
											   object:nil
	 ];
	/*[[[self buttonContainer] layer] setCornerRadius:12.0f];
	[[[self buttonContainer] layer] setBorderWidth:1.0f];
	[[[self buttonContainer] layer] setBorderColor:[UIColor blackColor].CGColor];
	[[[self buttonContainer] layer] setEdgeAntialiasingMask:kCALayerTopEdge];
	
	[[[self buttonContainer] layer] setShadowOffset:CGSizeMake(3, -3)];
	[[[self buttonContainer] layer] setShadowColor:[UIColor blackColor].CGColor];
	[[[self buttonContainer] layer] setShadowOpacity:0.5];
	[[[self buttonContainer] layer] setShadowRadius:2.0f];
	*/
	
	[[self topLeft] setBackgroundImage:[[UIImage imageNamed:@"1x1black"] stretchableImageWithLeftCapWidth:0 topCapHeight:0] forState:UIControlStateNormal];
	[[self topLeft] setBackgroundImage:[[UIImage imageNamed:@"1x1blue"] stretchableImageWithLeftCapWidth:0 topCapHeight:0] forState:UIControlStateHighlighted];
	
	
	[[self topCenter] setBackgroundImage:[[UIImage imageNamed:@"1x1black"] stretchableImageWithLeftCapWidth:0 topCapHeight:0] forState:UIControlStateNormal];
	[[self topCenter] setBackgroundImage:[[UIImage imageNamed:@"1x1blue"] stretchableImageWithLeftCapWidth:0 topCapHeight:0] forState:UIControlStateHighlighted];
	
	[[self topRight] setBackgroundImage:[[UIImage imageNamed:@"1x1black"] stretchableImageWithLeftCapWidth:0 topCapHeight:0] forState:UIControlStateNormal];
	[[self topRight] setBackgroundImage:[[UIImage imageNamed:@"1x1blue"] stretchableImageWithLeftCapWidth:0 topCapHeight:0] forState:UIControlStateHighlighted];
	
	[[self bottomLeft] setBackgroundImage:[[UIImage imageNamed:@"1x1black"] stretchableImageWithLeftCapWidth:0 topCapHeight:0] forState:UIControlStateNormal];
	[[self bottomLeft] setBackgroundImage:[[UIImage imageNamed:@"1x1blue"] stretchableImageWithLeftCapWidth:0 topCapHeight:0] forState:UIControlStateHighlighted];
	
	[[self bottomCenter] setBackgroundImage:[[UIImage imageNamed:@"1x1black"] stretchableImageWithLeftCapWidth:0 topCapHeight:0] forState:UIControlStateNormal];
	[[self bottomCenter] setBackgroundImage:[[UIImage imageNamed:@"1x1blue"] stretchableImageWithLeftCapWidth:0 topCapHeight:0] forState:UIControlStateHighlighted];
	
	[[self bottomRight] setBackgroundImage:[[UIImage imageNamed:@"1x1black"] stretchableImageWithLeftCapWidth:0 topCapHeight:0] forState:UIControlStateNormal];
	[[self bottomRight] setBackgroundImage:[[UIImage imageNamed:@"1x1blue"] stretchableImageWithLeftCapWidth:0 topCapHeight:0] forState:UIControlStateHighlighted];
	
	 
	UIView *buttonContainer = [[UIView alloc] initWithFrame:CGRectMake(22.0f, 124.0f, 275.0f, 211.0f)];
	
	float buttonHeight = buttonContainer.frame.size.height/2-2.0f;
	float buttonWidth = buttonContainer.frame.size.width/3-4.0f/3;
	[[self topLeft] setFrame:CGRectMake(0+1.0f, 
										0, 
										buttonWidth, 
										buttonHeight)
	 ];
	[[self topCenter] setFrame:CGRectMake(buttonWidth+1.0f, 
										  0, 
										  buttonWidth, 
										  buttonHeight)
	 ];
	[[self topRight] setFrame:CGRectMake(2*(buttonWidth)+1.0f, 
										 0, 
										 buttonWidth, 
										 buttonHeight)
	 ];
	[[self bottomLeft] setFrame:CGRectMake(0, 
										   buttonHeight, 
										   buttonWidth, 
										   buttonHeight)
	 ];
	[[self bottomCenter] setFrame:CGRectMake(buttonWidth+0.5f,
											 buttonHeight,
											 buttonWidth, 
											 buttonHeight)
	 ];
	[[self bottomRight] setFrame:CGRectMake(2*(buttonWidth)+1.0f,
											buttonHeight,
											buttonWidth, 
											buttonHeight)
	 ];
	
	//[[buttonContainer layer] setMasksToBounds:YES];
	[buttonContainer addSubview:[self topLeft]];
	[buttonContainer addSubview:[self topCenter]];
	[buttonContainer addSubview:[self topRight]];
	[buttonContainer addSubview:[self bottomLeft]];
	[buttonContainer addSubview:[self bottomCenter]];
	[buttonContainer addSubview:[self bottomRight]];
	
	//LACallButtonContainer *callButtonContainer = [[LACallButtonContainer alloc] initWithFrame:CGRectMake(22.0, 124.0, 275.0, 211.0)];
	LACallButtonContainer *callButtonContainer = [[LACallButtonContainer alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 275.0f, 211.0f)];
	//[callButtonContainer removeFromSuperview];
	[buttonContainer addSubview:callButtonContainer];
	[buttonContainer bringSubviewToFront:callButtonContainer];
	[[self view] addSubview:buttonContainer];
	[[buttonContainer layer] setBorderColor:[UIColor colorWithRed:0.3 green:0.3 blue:0.3 alpha:0.7].CGColor];
	[[buttonContainer layer] setBorderWidth:2.0];
	[[buttonContainer layer] setCornerRadius:10.0];
	//[[buttonContainer layer] setMasksToBounds:YES];
	//[[self view] bringSubviewToFront:callButtonContainer];
	
	[buttonContainer release];
	[callButtonContainer release];
}



/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

-(void)handleProximitySensorChange{
	NSLog(@"Handling proximity change");
	if([[UIDevice currentDevice] proximityState]){
		NSLog(@"Initiating recording");
		[self performSelector:@selector(takeStill) withObject:nil afterDelay:1];
	}
	else {
		if ([[self cameraManager] isMovieMode]) {
			[[self cameraManager] stopRecordingMovie];
		}
	}
}

-(void)takeStill{
	if (![[self cameraManager] isMovieMode]) {
		NSLog(@"Capturing still");
		[[self cameraManager] takeStill];
	}
	else {
		NSLog(@"Starting to record movie");
		[[self cameraManager] startRecordingMovie];
	}
}

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
	
}


- (void)dealloc {
    [super dealloc];
}

@end
