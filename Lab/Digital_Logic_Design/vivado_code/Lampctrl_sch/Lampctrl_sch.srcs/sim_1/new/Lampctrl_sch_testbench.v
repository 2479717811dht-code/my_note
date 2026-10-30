///
/*
程序功能：给设计源文件及功能编写仿真文件，验证设计是否满足要求。
*/
///
//1、设置仿真时间单位
//格式"`timescale 1ns / 1ps"，其中时间单位"1ps"
`timescale 1ns / 1ps

module Lampctrl_sch_testbench();
//2、定义信号类似
//与设计源文件对应，对应规则：一般输入信号定义为reg，输出信号定义为wire
    
    // Inputs
   reg S1;
   reg S2;
   reg S3;

// Output
   wire F;

//3、例化设计源文件
//注意第一个名字为设计源文件名，第二个满足源文件命名规则即可，这里为了方便起见，命名源文件名_UUT。

// Instantiate the UUT
   Lampctrl_sch Lampctrl_sch_UUT (
		.S1(S1), 
		.S2(S2), 
		.S3(S3), 
		.F(F)
		);

//4、添加激励（测试条件）

// Initialize Inputs
initial begin
//5、测试条件代码是顺序执行的
	S1 = 0;
	S2 = 0;
	S3 = 0;
	#50 S1 = 1;
//6、#50表示延迟50ns
	#50 S1 = 0;
	S2 = 1;
	#50 S1 = 1;
	#50 S1 = 0;
	S2 = 0;
	S3 = 1;
	#50 S1 = 1;
	#50 S1 = 0;
	S2 = 1;
	#50 S1 = 1;
	#50 S1 = 0;
	S2 = 0;
	S3 = 0;
end

endmodule
