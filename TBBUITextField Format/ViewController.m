//
//  ViewController.m
//  TBBUITextField Format
//
//  Created by tangbinbin on 16/7/15.
//  Copyright © 2016年 tangbinbin. All rights reserved.
//

#import "ViewController.h"
#import "UITextField+HLNumberFormatTextField.h"
#define kScreenWidth ([UIScreen mainScreen].bounds.size.width)
@interface ViewController ()<UITextFieldDelegate>
@property(nonatomic,strong)UITextField *phoneNumberTextfield;
@property(nonatomic,strong)UITextField *bankCardNumberTextfield;
@property(nonatomic,strong)UITextField *idCardNumberTextfield;
@end


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    
    self.phoneNumberTextfield = [[UITextField alloc]initWithFrame:CGRectMake((kScreenWidth-240)/2, 100, 240, 40)];
    self.phoneNumberTextfield.backgroundColor = [UIColor yellowColor];
    self.phoneNumberTextfield.placeholder = @"请输入手机号";
    [self.view addSubview:self.phoneNumberTextfield];
    
    self.bankCardNumberTextfield = [[UITextField alloc]initWithFrame:CGRectMake((kScreenWidth-240)/2, 150, 240, 40)];
    self.bankCardNumberTextfield.backgroundColor = [UIColor orangeColor];
    self.bankCardNumberTextfield.placeholder = @"请输入银行卡号";
    [self.view addSubview:self.bankCardNumberTextfield];
    
    self.idCardNumberTextfield = [[UITextField alloc]initWithFrame:CGRectMake((kScreenWidth-240)/2, 200, 240, 40)];
    self.idCardNumberTextfield.backgroundColor = [UIColor lightGrayColor];
    self.idCardNumberTextfield.placeholder = @"请输入身份证号";
    [self.view addSubview:self.idCardNumberTextfield];
    
    self.phoneNumberTextfield.delegate = self;
    self.phoneNumberTextfield.keyboardType = UIKeyboardTypeNumberPad;
    self.bankCardNumberTextfield.delegate = self;
    self.bankCardNumberTextfield.keyboardType = UIKeyboardTypeNumberPad;
    self.idCardNumberTextfield.delegate = self;


}

#pragma mark - UITextFieldDelegate
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {

    
    if(self.phoneNumberTextfield == textField) {
        return [UITextField numberFormatTextField:self.phoneNumberTextfield shouldChangeCharactersInRange:range replacementString:string textFieldType:kPhoneNumberTextFieldType];
    }else if (self.bankCardNumberTextfield == textField){
    
        return [UITextField numberFormatTextField:self.bankCardNumberTextfield shouldChangeCharactersInRange:range replacementString:string textFieldType:kBankCardNumberTextFieldType];
    }else{
    
        return [UITextField numberFormatTextField:self.idCardNumberTextfield shouldChangeCharactersInRange:range replacementString:string textFieldType:kIDCardNoTextFieldType];
    }
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}

@end
