# TBBTextFieldFormatInput
格式化输入手机号(XXX  XXXX  XXXX)身份证号(15或者18位XXXXXX  XXXXXXXX  XXXX)银行卡号(XXXX  XXXX  XXXX  XXXX  XXX  )
此项目主要用于一些号码的格式化输出，中间以空格分隔，删除的时候不会造成鼠标光标位置的混乱。

具体使用步骤请参照demo的viewcontroller文件：
1,在项目中引入头文件 #import "UITextField+HLNumberFormatTextField.h"
2,在UITextField的代理方法中判断输入框的类型，在返回时调用类方法
/**
 *  输入号码格式化
 *  参数 textField UITextField控件
 *  参数 range 文本范围
 *  参数 string 字符串
 *  参数 type 文本框输入号码类型（身份证，手机号，银行卡）
 */
+ (BOOL)numberFormatTextField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string textFieldType:(kTextFieldType)type;

 ************************************** 实现代码如下 *************************************
 
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{

    if(self.phoneNumberTextfield == textField) {
        return [UITextField numberFormatTextField:self.phoneNumberTextfield shouldChangeCharactersInRange:range replacementString:string textFieldType:kPhoneNumberTextFieldType];

    }else if (self.bankCardNumberTextfield == textField){
        return [UITextField numberFormatTextField:self.bankCardNumberTextfield shouldChangeCharactersInRange:range replacementString:string textFieldType:kBankCardNumberTextFieldType];

    }else{
        return [UITextField numberFormatTextField:self.idCardNumberTextfield shouldChangeCharactersInRange:range replacementString:string textFieldType:kIDCardNoTextFieldType];

    }
   return YES;

} 



