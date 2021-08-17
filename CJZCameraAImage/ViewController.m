//
//  ViewController.m
//  CJZCameraAImage
//
//  Created by Liang Hao on 2021/8/17.
//

#import "ViewController.h"
#import "CameraOperationViewController.h"
#import "CameraRecordViewController.h"
#import "VideoOperationViewController.h"
#import "AudioViewController.h"
#import "ImageOperationViewController.h"
#import "ImageTransformViewController.h"
#import "ImageRotateViewController.h"
#import "ImageResizeViewController.h"
#import "ImageCutoutViewController.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>
{
    NSArray* _operationList;
    NSArray* _operationVCList;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _operationList = @[@{@"CameraKit" : @[@"Camera Operation", @"Camera Record", @"Video Operation", @"Audio"]},
                       @{@"ImageKit" : @[@"Image Operation", @"Transform", @"Rotate", @"Resize", @"Cutout"]}];
    
    _operationVCList = @[@[[CameraOperationViewController new], [CameraRecordViewController new], [VideoOperationViewController new],  [AudioViewController new]], @[[ImageOperationViewController new], [ImageTransformViewController new], [ImageRotateViewController new],  [ImageResizeViewController new],  [ImageCutoutViewController new]]];
    
    [self buildView];
}

#pragma mark - BuildView
- (void)buildView {
    UITableView* tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 66, self.view.frame.size.width, self.view.frame.size.height - 66) style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
}

#pragma mark - UITableViewDelegate
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UILabel* titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 30)];
    NSString* subGroupTitle = [[[_operationList objectAtIndex:section] allKeys] firstObject];
    [titleLabel setText:subGroupTitle];
    return titleLabel;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSDictionary* subGroupInfo = [_operationList objectAtIndex:section];
    NSArray* subGroupList = [subGroupInfo objectForKey:[[subGroupInfo allKeys] firstObject]];
    return [subGroupList count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [_operationList count];
}

static NSString* cellIdentifier = @"CellIdentifier";
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:cellIdentifier];
    }
    NSDictionary* subGroupInfo = [_operationList objectAtIndex:indexPath.section];
    NSArray* subGroupList = [subGroupInfo objectForKey:[[subGroupInfo allKeys] firstObject]];
    cell.textLabel.text = [subGroupList objectAtIndex:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    UIViewController* operationClass = [[_operationVCList objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:operationClass animated:YES];
}

@end
