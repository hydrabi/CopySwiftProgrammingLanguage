//
//  AdvancedOperators.swift
//  IsASample
//
//  Created by Hydra on 16/7/21.
//  Copyright © 2016年 毕志锋. All rights reserved.
//

import Foundation

struct AdvancedVector2D {
    var x = 0.0,y = 0.0
}

//运算符函数
/*该运算符函数定义了一个全局的+函数，这个函数需要两个Vector2D类型的参数，返回值也是Vector2D类型。需要定义和实现一个中置运算的时候，在关键字func之前写上属性 @infix 就可以了。
 
 在这个代码实现中，参数被命名为了left和right，代表+左边和右边的两个Vector2D对象。函数返回了一个新的Vector2D的对象，这个对象的x和y分别等于两个参数对象的x和y的和。*/
func + (left:AdvancedVector2D,right:AdvancedVector2D) -> AdvancedVector2D {
    return AdvancedVector2D(x: left.x + right.x, y: left.y + right.y)
}

//前置和后置运算符
//上个例子演示了一个双目中置运算符的自定义实现，同样我们也可以玩标准单目运算符的实现。单目运算符只有一个操作数，在操作数之前就是前置的，如-a; 在操作数之后就是后置的，如i++。
prefix func - (vector:AdvancedVector2D) -> AdvancedVector2D{
    return AdvancedVector2D(x: -vector.x, y: -vector.y)
}

//组合赋值运算符
//还需要把运算符的左参数设置成inout，因为这个参数会在运算符函数内直接修改它的值
//因为加法运算在之前定义过了，这里无需重新定义。所以，加赋运算符函数使用已经存在的高级加法运算符函数来执行左值加右值的运算。
func += (left:inout AdvancedVector2D,right:AdvancedVector2D){
    left = left + right
}

//后置运算符
postfix func ++ (vector:inout AdvancedVector2D) -> AdvancedVector2D {
    vector += AdvancedVector2D(x: 1.0, y: 1.0)
    return vector
}

//比较运算符
func == (left:AdvancedVector2D,right:AdvancedVector2D) -> Bool {
    return (left.x == right.x) && (left.y == right.y)
}

//不等运算符
func != (left:AdvancedVector2D,right:AdvancedVector2D) -> Bool {
    return  !(left == right)
}

//自定义运算符
//标准的运算符不够玩，那你可以声明一些个性的运算符，但个性的运算符只能使用这些字符 / = - + * % < >！& | ^。~。
//prefix func +++ (vector:inout AdvancedVector2D) -> AdvancedVector2D {
//    vector += vector
//    return vector
//}

//自定义中置运算符的优先级和结合性
//结合性(associativity)的值可取的值有left，right和none。左结合运算符跟其他优先级相同的左结合运算符写在一起时，会跟左边的操作数结合。同理，右结合运算符会跟右边的操作数结合。而非结合运算符不能跟其他相同优先级的运算符写在一起。
//结合性(associativity)的值默认为none，优先级(precedence)默认为100。
//以下例子定义了一个新的中置符+-，是左结合的left，优先级为140
infix operator +- {associativity left precedence 140}
func +- (left:AdvancedVector2D,right:AdvancedVector2D) -> AdvancedVector2D{
    return AdvancedVector2D(x: left.x+right.x, y: left.y-right.y)
}


class AdvancedOperators:ViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func start () {
        
        //按位取反运算符
        //按位取反运算符~对一个操作数的每一位都取反。
        let initialBits:UInt8  = 0b0001111
        let invertedBits       = ~initialBits

        //按位与运算符
        //按位与运算符对两个数进行操作，然后返回一个新的数，这个数的每个位都需要两个输入数的同一位都为1时才为1。
        let firstSixBits:UInt8 = 0b11111100
        let lastSixBits:UInt8  = 0b00111111
        
        //按位或运算
        //按位或运算符|比较两个数，然后返回一个新的数，这个数的每一位设置1的条件是两个输入数的同一位都不为0(即任意一个为1，或都为1)。
        let someBits:UInt8 = 0b10110010
        let moreBits:UInt8 = 0b01011110
        let combinedBits = someBits | moreBits
        
        //按位异或运算符
        //按位异或运算符^比较两个数，然后返回一个数，这个数的每个位设为1的条件是两个输入数的同一位不同，如果相同就设为0。
        let firstBits:UInt8 = 0b00010100
        let otherBits:UInt8 = 0b00000101
        let outputBits = firstBits ^ otherBits
        
        //按位左移/右移运算符
        //按位左移和按位右移的效果相当把一个整数乘于或除于一个因子为2的整数。向左移动一个整型的比特位相当于把这个数乘于2，向右移一位就是除于2
        
        //无符整型的移位操作
        //对无符整型的移位的效果如下：
        //已经存在的比特位向左或向右移动指定的位数。被移出整型存储边界的的位数直接抛弃，移动留下的空白位用零0来填充。这种方法称为逻辑移位。
        let shiftBits: UInt8 = 4   // 即二进制的00000100
        shiftBits << 1             // 00001000
        shiftBits << 2             // 00010000
        shiftBits << 5             // 10000000
        shiftBits << 6             // 00000000
        shiftBits >> 2             // 00000001
        
        //这个例子使用了一个UInt32的命名为pink的常量来存储层叠样式表CSS中粉色的颜色值，CSS颜色#CC6699在Swift用十六进制0xCC6699来表示。然后使用按位与(&)和按位右移就可以从这个颜色值中解析出红(CC)，绿(66)，蓝(99)三个部分
        //对0xCC6699和0xFF0000进行按位与&操作就可以得到红色部分。0xFF0000中的0了遮盖了OxCC6699的第二和第三个字节，这样6699被忽略了，只留下0xCC0000。
        //然后，按向右移动16位，即 >> 16。十六进制中每两个字符是8比特位，所以移动16位的结果是把0xCC0000变成0x0000CC。这和0xCC是相等的，都是十进制的204。
        //同样的，绿色部分来自于0xCC6699和0x00FF00的按位操作得到0x006600。然后向右移动8們，得到0x66，即十进制的102。
        //最后，蓝色部分对0xCC6699和0x0000FF进行按位与运算，得到0x000099，无需向右移位了，所以结果就是0x99，即十进制的153
        let pink: UInt32 = 0xCC6699
        let redComponent = (pink & 0xFF0000) >> 16    // redComponent 是 0xCC, 即 204
        let greenComponent = (pink & 0x00FF00) >> 8   // greenComponent 是 0x66, 即 102
        let blueComponent = pink & 0x0000FF           // blueComponent 是 0x99, 即 153
        
        //有符整型的移位操作
        //有符整型通过第1个比特位(称为符号位)来表达这个整数是正数还是负数。0代表正数，1代表负数。其余的比特位(称为数值位)存储其实值。有符正整数和无符正整数在计算机里的存储结果是一样的，
        //符号位为0，代表正数，另外7比特位二进制表示的实际值就刚好是4
        //0 0000000 = 4
        //负数呢，跟正数不同。负数存储的是2的n次方减去它的绝对值，n为数值位的位数。一个8比特的数有7个数值位，所以是2的7次方，即128
        //1 1111100 = -4
        
        //第二，由于使用二进制补码表示，我们可以和正数一样对负数进行按位左移右移的，同样也是左移1位时乘于2，右移1位时除于2。要达到此目的，对有符整型的右移有一个特别的要求：
        //对有符整型按位右移时，使用符号位(正数为0，负数为1)填充空白位。这就确保了在右移的过程中，有符整型的符号不会发生变化。这称为算术移位。
        
        //溢出运算符
        //默认情况下，当你往一个整型常量或变量赋于一个它不能承载的大数时，Swift不会让你这么干的，它会报错。这样，在操作过大或过小的数的时候就很安全了
        var potentialOverflow = Int16.max
        // potentialOverflow 等于 32767, 这是 Int16 能承载的最大整数
        //potentialOverflow = potentialOverflow + 1
        //报错
        
        //当然，你有意在溢出时对有效位进行截断，你可采用溢出运算，而非错误处理。Swfit为整型计算提供了5个&符号开头的溢出运算符。
        //值的上溢出,溢出变为0
        potentialOverflow = potentialOverflow &+ 1
        
        //值得下溢出
        //UInt8的最小值是0(二进制为00000000)。使用&-进行溢出减1，就会得到二进制的11111111即十进制的255。
        
        var willUnderflow = UInt8.min
        // willUnderflow 等于UInt8的最小值0
        willUnderflow = willUnderflow &- 1
        // 此时 willUnderflow 等于 255
        
        /*有符整型也有类似的下溢出，有符整型所有的减法也都是对包括在符号位在内的二进制数进行二进制减法的，这在 "按位左移/右移运算符" 一节提到过。最小的有符整数是-128，即二进制的10000000。用溢出减法减去去1后，变成了01111111，即UInt8所能承载的最大整数127*/
        var signedUnderflow = Int8.min
        // signedUnderflow 等于最小的有符整数 -128
        signedUnderflow = signedUnderflow &- 1
        // 如今 signedUnderflow 等于 127
        
        let vector = AdvancedVector2D(x: 3.0, y: 1.0)
        let anotherVector = AdvancedVector2D(x: 2.0, y: 4.0)
        let combinedVector = vector + anotherVector
        
        var original = AdvancedVector2D(x: 1.0, y: 2.0)
        let vectorToAdd = AdvancedVector2D(x: 3.0, y: 4.0)
        original += vectorToAdd
        
        var toIncrement = AdvancedVector2D(x: 3.0, y: 4.0)
        let afterIncrement = toIncrement++
        
        let twoThree = AdvancedVector2D(x: 2.0, y: 3.0)
        let anotherTwoThree = AdvancedVector2D(x: 2.0, y: 3.0)
        if twoThree == anotherTwoThree{
            print("这两个向量是相等的")
        }
        
        //Vector2D 的 +++ 的实现和 ++ 的实现很接近, 唯一不同的前者是加自己, 后者是加值为 (1.0, 1.0) 的向量.
        var toBeDoubled = AdvancedVector2D(x: 1.0, y: 4.0)
    }
}
