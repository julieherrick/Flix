//
//  DetailsViewController.m
//  Flix
//
//  Created by Julie Herrick on 6/25/20.
//  Copyright © 2020 Julie Herrick. All rights reserved.
//

#import "DetailsViewController.h"
#import "MovieCell.h"
#import "UIImageView+AFNetworking.h"

@interface DetailsViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *backdropView;
@property (weak, nonatomic) IBOutlet UIImageView *posterView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *synopsisLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSString *baseURLString = @"https://image.tmdb.org/t/p/w500";
    NSString *baseURLStringSmall = @"https://image.tmdb.org/t/p/w200";
    NSString *posterURLString = self.movie[@"poster_path"];
    NSString *fullPosterURLString = [baseURLString stringByAppendingString:posterURLString];
    NSString *fullPosterURLStringSmall = [baseURLStringSmall stringByAppendingString:posterURLString];
    
    NSURL *posterURL = [NSURL URLWithString:fullPosterURLString];
    NSURL *posterURLSmall = [NSURL URLWithString:fullPosterURLStringSmall];
//    [self.posterView setImageWithURL:posterURL];
//    self.posterView.alpha = 0;
//    [UIView animateWithDuration:.3 animations:^{
//    self.posterView.alpha = 1.0;
//           }];
    
    
    NSURLRequest *requestSmallPoster = [NSURLRequest requestWithURL:posterURLSmall];
    NSURLRequest *reqestLargePoster = [NSURLRequest requestWithURL:posterURL];
    
    __weak DetailsViewController *weakSelf = self;
    
    [self.posterView setImageWithURLRequest:requestSmallPoster placeholderImage:nil success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *smallImage) {
        // smallImageResponse will be nil if the smallImage is already available
        // in cache (might want to do something smarter in that case).
        weakSelf.posterView.alpha = 0.0;
        weakSelf.posterView.image = smallImage;
        
        [UIView animateWithDuration:0.3 animations:^{
            weakSelf.posterView.alpha = 1.0;
        } completion: ^(BOOL finished) {
            // The AFNetworking ImageView Category only allows one request to be sent at a time
            // per ImageView. This code must be in the completion block.
            [weakSelf.posterView setImageWithURLRequest:reqestLargePoster placeholderImage:smallImage success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *largeImage) {
                weakSelf.posterView.image = largeImage;
            }
                failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
                // do something for the failure condition of the large image request
                // possibly setting the ImageView's image to a default image
                
            }];
        }];
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error){
        // do something for the failure condition
        // possibly try to get the large image
    }];
    
    NSString *backdropURLString = self.movie[@"backdrop_path"];
    if (backdropURLString == (id) [NSNull null]) {
        backdropURLString = posterURLString;
    }
    NSString *fullBackdropURLString = [baseURLString stringByAppendingString:backdropURLString];
    NSString *fullBackdropURLStringSmall = [baseURLStringSmall stringByAppendingString:backdropURLString];
    
    NSURL *backdropURL = [NSURL URLWithString:fullBackdropURLString];
    NSURL *backdropURLSmall = [NSURL URLWithString:fullBackdropURLStringSmall];
//    [self.backdropView setImageWithURL:backdropURL];
//    self.backdropView.alpha = 0;
//    [UIView animateWithDuration: .9 animations:^{
//    self.backdropView.alpha = 1.0;
//           }];
    
    NSURLRequest *requestSmallBackdrop = [NSURLRequest requestWithURL:backdropURLSmall];
    NSURLRequest *reqestLargeBackdrop = [NSURLRequest requestWithURL:backdropURL];

    [self.backdropView setImageWithURLRequest:requestSmallBackdrop placeholderImage:nil success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *smallImage) {
        // smallImageResponse will be nil if the smallImage is already available
        // in cache (might want to do something smarter in that case).
        weakSelf.backdropView.alpha = 0.0;
        weakSelf.backdropView.image = smallImage;
        
        [UIView animateWithDuration:0.3 animations:^{
            weakSelf.backdropView.alpha = 1.0;
        } completion: ^(BOOL finished) {
            // The AFNetworking ImageView Category only allows one request to be sent at a time
            // per ImageView. This code must be in the completion block.
            [weakSelf.backdropView setImageWithURLRequest:reqestLargeBackdrop placeholderImage:smallImage success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *largeImage) {
                weakSelf.backdropView.image = largeImage;
            }
                failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
                // do something for the failure condition of the large image request
                // possibly setting the ImageView's image to a default image
                
            }];
        }];
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error){
        // do something for the failure condition
        // possibly try to get the large image
    }];
    
    
    self.titleLabel.text = self.movie[@"title"];
    self.synopsisLabel.text = self.movie[@"overview"];
    self.dateLabel.text = self.movie[@"release_date"];
    
    [self.titleLabel sizeToFit];
    [self.synopsisLabel sizeToFit];
    [self.dateLabel sizeToFit];
    
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
