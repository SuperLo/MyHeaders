//
//  MyBaseTableView.m
//  MyHeaders
//
//  Created by hzxh on 2023/4/18.
//

#import "MyBaseTableView.h"
@interface MyBaseTableView ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)NSString *cellName;
@property(nonatomic,assign)CGFloat rowHei;
@property(nonatomic,assign)BOOL hasArrow;

@end
@implementation MyBaseTableView
- (instancetype)initWithCellName:(NSString *)cellName RowHeight:(CGFloat)rowHeight{
    self=[super initWithFrame:CGRectZero style:UITableViewStylePlain];
    if (self) {
        _cellName=cellName;
        _sections=1;
        _rowHei=rowHeight;
        _listArray=NSMutableArray.new;
        _hasArrow=YES;
        self.alwaysBounceVertical=NO;
        [self setupUI];
    }
    return self;
}
- (instancetype)initWithCellName:(NSString *)cellName RowHeight:(CGFloat)rowHeight Arrow:(BOOL)hasArrow{
    self=[super initWithFrame:CGRectZero style:UITableViewStylePlain];
    if (self) {
        _cellName=cellName;
        _sections=1;
        _rowHei=rowHeight;
        _listArray=NSMutableArray.new;
        _hasArrow=hasArrow;
        [self setupUI];
    }
    return self;
}
-(void)setupUI{
    self.delegate=self;
    self.dataSource=self;
    self.backgroundColor=UIColor.clearColor;
}
- (void)setSections:(NSInteger)sections{
    _sections=sections;
    [self reloadData];
}
- (void)setListArray:(NSMutableArray *)listArray{
    _listArray=listArray;
    [self reloadData];
    
}
- (void)setCanEdit:(BOOL)canEdit{
    _canEdit=canEdit;
}
#pragma - mark - //table
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.sections?self.sections:1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.sections<=1) {
        return self.listArray.count;
    }else{
        return [self.listArray[section] count];
    }
    return self.listArray.count;;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.rowHei;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *identify=[NSString stringWithFormat:@"%ldr%@",indexPath.row,self.cellName];
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identify];
    if (!cell) {
        cell=[[NSClassFromString(self.cellName) alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];;
        if (self.hasArrow) {
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        }else{
            cell.accessoryType=UITableViewCellAccessoryNone;
        }
    }
    if (self.BlockSetupCellAtIndexPath) {
        self.BlockSetupCellAtIndexPath(indexPath, cell);
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (self.BlockDidSelectedItemAtIndexPath) {
        self.BlockDidSelectedItemAtIndexPath(indexPath, cell);
    }
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.canEdit;
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle==UITableViewCellEditingStyleDelete) {
        if (self.BlockDeleteCellAtIndexPath) {
            self.BlockDeleteCellAtIndexPath(indexPath);
        }
    }
}

@end
