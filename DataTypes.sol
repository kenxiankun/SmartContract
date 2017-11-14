pragma solidity ^0.4.12;


contract DataTypes
{
    bool result;
    
    int i = 9;
    //fixed j = 9.5;
    ///fixed m = 0;
    int r;
    int8 k = 9;
    uint b;
    
    enum PaymentMethod {PAYPAL, CASH, DIRECT_TRANSFER}
    PaymentMethod defaultChoice = PaymentMethod.CASH;
    
    
    event afterValueAssigned(string m, bool res);
    
    event afterAddressModified(string m, address, uint256 amount);
    
    event afterByteAssigned(string m, bytes1, bytes32);
    
    event checkArrrayLength(string m, uint8 len);
    
    event checkEnum(string m, uint value);
    
    function testNumeric() {
        
        if( i <= 9) { result = true;}
        
        afterValueAssigned("i <=9 ", result);
        
        //if(j <= 9) { result = false; }
        
        //afterValueAssigned("j <=9 ", result);
        
        if(!result)
        {
            afterValueAssigned("result is false ", result);
        }
        
       /* 
        if(!result && (j < 10))
        {
            afterValueAssigned("result is false and j < 10 ", result);
        }
        else
        {
            afterValueAssigned("error?? ", result);
        }
        
        
        if(fixed(i) < j)
        {
           afterValueAssigned("convert i to fixed, and compare ", true); 
        }
        
        if(i < int(j))
        {
           afterValueAssigned("convert j to int, and compare ", true); 
        }
        
        m = fixed(i) * j;
        
        m = m + j * fixed(2**2);
        
        if(m == 89.5) { afterValueAssigned("calc done correctly ", true); }
        */
        
        r = i%10;
        
        if(r == 9) {afterValueAssigned("% calc done correctly ", true); }
            
    }
    
    function  testAddress () payable {
        
        address d = msg.sender;
        
        address nameReg = 0x72ba7d8e73fe8eb666ea66babc8116a41bfb10e2;
        nameReg.call.gas(10000).value(1 ether)("register", "MyName");
        
        afterAddressModified("nameReg ", nameReg, nameReg.balance);
        
        b = d.balance;
        afterAddressModified("initial balance", d, b);
        
        //d.transfer(100);
        //afterAddressModified("after transfered 100 ", d, d.balance);
        
        //d.send(50);
        //afterAddressModified("after sent balance", d, d.balance);
        
    }
    
    function testArray()
    {
        bytes1 a = 0xaf;
        bytes32 b = 0xaf;
        
        afterByteAssigned("diff in bytes type:", a, b);
        
        checkArrrayLength("the length of array a:", a.length);
        checkArrrayLength("the length of array b:", b.length);
        
        for (uint i = 0; i < 32; i++)
        {
            bytes1 x = b[i];
           
           afterByteAssigned("each elements inside:", x, b); 
        }
    }
    
    function testEnum()
    {
        //EVM convert the values - PAYPAL, CASH, DIRECT_TRANSFER to 0, 1, 2
        PaymentMethod choice = PaymentMethod.PAYPAL;
        
        checkEnum("choice = ", uint(choice));
        checkEnum("defaultChoice = ", uint(defaultChoice));
        
        if(defaultChoice != choice)
        {
            choice = PaymentMethod.DIRECT_TRANSFER;
            checkEnum("updated choice = ", uint(choice));
        }
    }
    
}
