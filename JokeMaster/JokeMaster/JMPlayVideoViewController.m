//
//  JMPlayVideoViewController.m
//  JokeMaster
//
//  Created by priyanka on 12/06/17.
//  Copyright © 2017 esolz. All rights reserved.
//

#import "JMPlayVideoViewController.h"

@interface JMPlayVideoViewController ()

@end

@implementation JMPlayVideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
        [_reviewTable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    

    
    NSURL *videoURL = [NSURL URLWithString:@"https://github.com/versluis/Movie-Player/blob/master/Movie%20Player/video.mov?raw=true"];
    
    AVPlayer *player = [AVPlayer playerWithURL:videoURL];
    
    // create a player view controller
    AVPlayerViewController *controller = [[AVPlayerViewController alloc]init];
    controller.player = player;
    [controller setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    
     [player play];
    
    // show the view controller
    [self addChildViewController:controller];
       [_playerView addSubview:controller.view];
        controller.view.frame= CGRectMake(0, 0, _playerView.frame.size.width, _playerView.frame.size.height);
 
    [self setRoundCornertoView:_videoThumb withBorderColor:[UIColor clearColor] WithRadius:0.15];
    
    
      [self setRoundCornertoView:_playerView withBorderColor:[UIColor clearColor] WithRadius:0.15];

    // Do any additional setup after loading the view.
}


#pragma mark - UITableView Delegates
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
//{
//    return 0;
//    
//}
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    
////    NSString *identifier = @"CountryCell";
////    
////    CountryCell *cell = (CountryCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
////    
////    cell.selectionStyle = UITableViewCellSelectionStyleNone;
////    
////    cell.CheckImage.tag=indexPath.row+500;
////    cell.CheckButton.tag=indexPath.row;
////    [cell.CheckButton addTarget:self action:@selector(CheckButtonTap:) forControlEvents:UIControlEventTouchUpInside];
////    
////    return cell;
////    
////    
//    
//    
//    
//}
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
////    if (IsIphone5 || IsIphone4)
////    {
////        return 50;
////    }
////    else
////    {
////        return 60;
////    }
//    
//}
//
//-(void) tableView:(UITableView *)tableView willDisplayCell:(CountryCell *) cell forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    
//    
//    
//    
//    [cell.CountryImage setImage:[UIImage imageNamed:[CountryArray objectAtIndex:indexPath.row]]] ;
//    
//    [cell.CountryLabel setText:AMLocalizedString([[CountryArray objectAtIndex:indexPath.row]uppercaseString], nil) ];
//    
//    
//}
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    
//}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)backClicked:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
@end
