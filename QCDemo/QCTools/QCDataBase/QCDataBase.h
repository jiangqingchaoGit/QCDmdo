//
//  QCDataBase.h
//  QCDemo
//
//  Created by JQC on 2020/10/30.
//  Copyright © 2020 JQC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QCChatModel.h"
#import "QCListModel.h"
#import "QCAssociatedModel.h"

/*
 *  FMDB 头文件
 */
#import "FMDatabase.h"
#import "FMDatabaseQueue.h"

NS_ASSUME_NONNULL_BEGIN

@interface QCDataBase : NSObject
@property(strong,nonatomic)FMDatabase * database;

+ (QCDataBase *)shared;
- (void)createFMDB;

-(void)insertChatModel:(QCChatModel *)model;
-(void)deleteChatModel:(QCChatModel *)model;
-(void)updateChatModel:(QCChatModel *)model;
-(NSMutableArray *)queryChatModel:(QCChatModel *)model;
-(void)removeAllChatModel:(QCChatModel *)model;

-(void)insertListModel:(QCListModel *)model;
-(void)deleteListModel:(QCListModel *)model;
-(void)updateListModel:(QCListModel *)model;
-(NSMutableArray *)queryListModel:(QCListModel *)model;
- (void )queryByListId:(QCListModel *)model;
-(void)removeAllListModel:(QCListModel *)model;

-(void)insertAssociatedModel:(QCAssociatedModel *)model;
-(void)deleteAssociatedModel:(QCAssociatedModel *)model;
-(void)updateAssociatedModel:(QCAssociatedModel *)model;
-(NSMutableArray *)queryAssociatedModel:(QCAssociatedModel *)model;
-(void)removeAllAssociatedModel:(QCAssociatedModel *)model;

@end

NS_ASSUME_NONNULL_END
