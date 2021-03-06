/*
 Copyright 2009-2010 Urban Airship Inc. All rights reserved.

 Redistribution and use in source and binary forms, with or without
 modification, are permitted provided that the following conditions are met:

 1. Redistributions of source code must retain the above copyright notice, this
 list of conditions and the following disclaimer.

 2. Redistributions in binaryform must reproduce the above copyright notice,
 this list of conditions and the following disclaimer in the documentation
 and/or other materials provided withthe distribution.

 THIS SOFTWARE IS PROVIDED BY THE URBAN AIRSHIP INC``AS IS'' AND ANY EXPRESS OR
 IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
 MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO
 EVENT SHALL URBAN AIRSHIP INC OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT,
 INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
 BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
 DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
 LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
 OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
 ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

#import "UAPushSettingsTokenViewController.h"
#import "UAirship.h"


@implementation UAPushSettingsTokenViewController

@synthesize emailButton;
@synthesize copyButton;
@synthesize tokenLabel;

- (void)dealloc {
    [copyButton release];
    [emailButton release];
    [tokenLabel release];
    [text release];
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"Device Token";

    // TODO: get description from server
    text = @"This is a very loooooooooooooooooooooooooooooooooooooooooooooooooo"
           @"ooooooooooooooooooooooooooooooooooooooooooooooooooong description";

    tokenLabel.text = [UAirship shared].deviceToken ? [UAirship shared].deviceToken : @"Unavailable";
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}

- (void)viewDidUnload {
    [super viewDidUnload];
    self.copyButton = nil;
    self.emailButton = nil;
    self.tokenLabel = nil;
}

#pragma mark -
#pragma mark UITableViewDelegate

#define kCellPaddingHeight 10

- (CGFloat)tableView: (UITableView *) tableView heightForRowAtIndexPath:(NSIndexPath *) indexPath {
    UIFont *font = [UIFont systemFontOfSize:17];
    CGFloat height = [text sizeWithFont:font
                      constrainedToSize:CGSizeMake(280.0, 1500.0)
                          lineBreakMode:UILineBreakModeWordWrap].height;
    return height + kCellPaddingHeight;
}

#pragma mark -
#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UIImage *bgImage = [UIImage imageNamed:@"middle-detail.png"];
    UIImage *stretchableBgImage = [bgImage stretchableImageWithLeftCapWidth:20 topCapHeight:0];
    UIImageView *bgImageView = [[UIImageView alloc] initWithImage: stretchableBgImage];

    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"description-cell"];
    if (!cell)
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                       reuseIdentifier:@"description-cell"] autorelease];

    UIFont *font = [UIFont systemFontOfSize: 17];

    UILabel* description = [[UILabel alloc] init];
    description.text = text;
    description.lineBreakMode = UILineBreakModeWordWrap;
    description.numberOfLines = 0;
    description.backgroundColor = [UIColor clearColor];
    [description setFont: font];
    CGFloat height = [text sizeWithFont:font
                      constrainedToSize:CGSizeMake(280.0, 800.0)
                          lineBreakMode:UILineBreakModeWordWrap].height;
    [description setFrame: CGRectMake(0.0f, 10.0f, 320.0f, height)];
    [description setBounds: CGRectMake(0.20f, 0.0f, 290.0f, height)];
    [description setAutoresizingMask:UIViewAutoresizingFlexibleWidth];

    [cell addSubview: description];
    [cell setSelectionStyle: UITableViewCellSelectionStyleNone];
    [cell setBackgroundView: bgImageView];

    [description release];
    [bgImageView release];

    return cell;
}

@end
