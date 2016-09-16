//
//  PVReplyTableViewController.m
//  PortVibe
//
//  Created by Armand Obreja 05-17-2014
//  Copyright (c) 2014 Armand. All rights reserved.

#import "PVReplyTableViewController.h"

@implementation PVReplyTableViewController
@synthesize replyCell;
static NSString *cellReplyIdentifier = @"ReplyCell";

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self)
    {
        mainArray = [[NSArray alloc] initWithObjects:@"Just bumped into everyone from my class! This is turning out to be a great night. aksjdfsijadhf isadgfiyqgf78gq78g f78g2 784fg IT WORKSSSSS YOOOO", @"dsadf asdf sadf", @"asddsf adsfasfsadfwer31333 333", @"$3.33 shots tonight, $4.50 Mott's Clamattos! Come join me if you're around sdfjhsdiufh qigr qy8gr8qg2r8 gqw8egf86qwg8fg18gf78qwgf8 wq8efg83g8g f8qgf 87ewgf87qgwef87gqe87f gqe78fg 78eqwgf87ewqgf87egqwf78g wq87efg87qweg fgqw87egf 78qwegf78 qwge8f7gqew798fgwq87egf87q wgef qgwegf78wqegf78weqgf87weqgf 87 qwg akjsdbfksajdbf isadbfidasfiuysdaf ysadgfysdagfy sdgyfgsdyagfiyads gf adisgfiysdag fiygsadif isdagfiysdagfiygsadfgy sadiyfgsyiadgfiysdgfiysdgifygasdiyfgisaydgf hahaha", @"Working out, getting back in shape.", @"So many people here smoking cigarettes. Good vibes but not my scene. masdfbksabdf adfsabisadbfiasbdfsad IT WORKSSSSSSS", @"What up 202 Albert! Please tell the janitors someone threw up in the lobby. Wasn't me. IT IS STILL WORKING", @"Just had a game of soccer with new people I just met via PortVibe. SUCCESS", @"This is the best gym I've ever been to.  The staff is super friendly. WORKS", @"Steaks were $8 today each, special promotion. Really high quality food", @"Sun is perfect today.  Just played football with some guys via PortVibe. Great start to the summer akjshfsahfisadgfis fugfiygsa ifiasdifhsd WORKS!!!", nil];
        displayName = [[NSArray alloc] initWithObjects:@"SportGirl333", @"blahblah", @"NoComment", @"MulletHead22", @"T-RexSam", @"PortVibeFan", @"Kevin Stylls", @"Batman2222", @"SuperDooper", @"80813423", @"HeatherLowBro33", nil];
        userTime = [[NSArray alloc] initWithObjects:@"12 mins", @"14 mins", @"1 hour", @"3 hours", @"7 hours", @"11 hours", @"Yesterday", @"Yesterday", @"Yesterday", @"23/06/02", @"21/06/02", nil];
    }
    return self;
}

-(void)viewDidLoad
{
    if ([[UIScreen mainScreen] bounds].size.height == 568)
    {
        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(5, 5, 290, 220) style:UITableViewStylePlain];
    }
    else
    {
        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(5, 5, 290, 180) style:UITableViewStylePlain];
    }
    
    [self.tableView registerNib:[UINib nibWithNibName:@"PVReplyTableViewCell"
                                               bundle:nil]
         forCellReuseIdentifier:cellReplyIdentifier];
}

-(void)viewDidAppear:(BOOL)animated
{
    [self.tableView reloadData];
    // reset the scrolling to the top of the table view
    if ([self tableView:self.tableView numberOfRowsInSection:0] > 0)
    {
        NSIndexPath *topIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        [self.tableView scrollToRowAtIndexPath:topIndexPath atScrollPosition:UITableViewScrollPositionTop animated:NO];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *replyText = [mainArray objectAtIndex:indexPath.row];
    CGFloat width = replyCell.userComment.frame.size.width;
    UIFont *font = [UIFont fontWithName:@"HelveticaNeue" size:12];
    NSAttributedString *attributedText =
    [[NSAttributedString alloc]
     initWithString:replyText
     attributes:@
     {
     NSFontAttributeName: font
     }];
    CGRect rect = [attributedText boundingRectWithSize:(CGSize){width, CGFLOAT_MAX}
                                               options:NSStringDrawingUsesLineFragmentOrigin
                                               context:nil];
    CGSize heightOfText = rect.size;
    return heightOfText.height+105;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [mainArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    replyCell = (PVReplyTableViewCell *)[self.tableView dequeueReusableCellWithIdentifier:cellReplyIdentifier];
    replyCell.userPhoto.layer.cornerRadius = replyCell.userPhoto.frame.size.height/2.8;
    replyCell.userPhoto.layer.masksToBounds = YES;
    replyCell.userPhoto.layer.borderColor = [UIColor lightGrayColor].CGColor;
    replyCell.userPhoto.layer.borderWidth = 1.0;
    replyCell.userComment.text = [mainArray objectAtIndex:indexPath.row];
    [replyCell.userName setTitle:[displayName objectAtIndex:indexPath.row] forState:UIControlStateNormal];
    
    replyCell.postTime.text = [userTime objectAtIndex:indexPath.row];
    UIImage *image = [[UIImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%i", indexPath.row+1] ofType:@"jpeg"]];
    [replyCell.userPhoto setImage:image];
    return replyCell;
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}

@end
