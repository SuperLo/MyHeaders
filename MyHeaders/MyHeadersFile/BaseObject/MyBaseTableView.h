//
//  MyBaseTableView.h
//  MyHeaders
//
//  Created by hzxh on 2023/4/18.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MyBaseTableView : UITableView
- (instancetype)initWithCellName:(NSString *)cellName RowHeight:(CGFloat)rowHeight;
- (instancetype)initWithCellName:(NSString *)cellName RowHeight:(CGFloat)rowHeight Arrow:(BOOL)hasArrow;
@property(nonatomic,assign)NSInteger sections;
@property(nonatomic,assign)BOOL canEdit;
@property(nonatomic,strong)NSMutableArray *listArray;

@property(nonatomic,copy)void (^BlockSetupCellAtIndexPath)(NSIndexPath *indexPath,UITableViewCell *cell);
@property(nonatomic,copy)void (^BlockDidSelectedItemAtIndexPath)(NSIndexPath *indexPath,UITableViewCell *cell);
@property(nonatomic,copy)void (^BlockDeleteCellAtIndexPath)(NSIndexPath *indexPath);
@end

NS_ASSUME_NONNULL_END
