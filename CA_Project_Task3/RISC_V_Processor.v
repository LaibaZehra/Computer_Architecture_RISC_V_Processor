`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/27/2023 02:24:56 PM
// Design Name: 
// Module Name: RISC_V_Processor
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////









module RISC_V_Processor(  
    input clk, reset,  
    output wire [63:0] PC_In,  //prev MEM_WB_inst add  
    output wire [63:0] PC_Out,  //new MEM_WB_ins add  
    output wire [31:0] MEM_WB_instruction,  //MEM_WB_ins  
    output wire [6:0] opcode, //opcode  
    output wire [4:0] rs1,    output wire [4:0] rs2,  
    output wire [4:0] rd,  
    output wire [63:0] WriteData, //in rd  
    output wire [63:0] ReadData1,  
    output wire [63:0] ReadData2, //writedata (mem)  
    output wire Branch, MemWrite, MemRead, MemtoReg,  
    output wire [1:0] ALUOp,  
    output wire ALUSrc, RegWrite,  
    output wire [63:0] Result, //Mem_Add  
    output wire [63:0] read_mem_data,  
    output  wire [63:0]imm_data,  
    output wire [3:0] operation,  
    output wire ZERO,  
    output wire [63:0] ALU_input2,  
    output wire[63:0] branch_adder,  
    output wire[63:0] imm
    

    

);  

  

wire [63:0] normal_adder;  
wire [2:0] funct3;  
wire [6:0] funct7;  
wire [3:0] Func;  
//ID_EX wires
wire [63:0] ID_EX_PC_Out, ID_EX_ReadData1,ID_EX_ReadData2, ID_EX_imm_data; 
wire [3:0] ID_EX_Func; 
wire [4:0] ID_EX_rd; 
wire ID_EX_MemtoReg, ID_EX_RegWrite,ID_EX_Branch, ID_EX_MemWrite, ID_EX_MemRead, ID_EX_ALUSrc; 
wire [1:0] ID_EX_ALUOp; 
wire [2:0] ID_EX_funct3; 
//EX_MEM wires
wire EX_MEM_RegWrite, EX_MEM_MemtoReg, EX_MEM_Branch,EX_MEM_Zero, EX_MEM_MemWrite, EX_MEM_MemRead; 
wire [63:0] EX_MEM_branch_adder, EX_MEM_Result, EX_MEM_ReadData2;
wire [3:0] EX_MEM_Func; 
wire [4:0] EX_MEM_EX_MEM_rd; 
//MEM_WB wires
wire MEM_WB_RegWrite, MEM_WB_MemtoReg; 
wire [63:0] MEM_WB_read_mem_data,MEM_WB_Result; 
wire [4:0] MEM_WB_rd; 
wire [31:0]  MEM_WB_ins;
wire [63:0] MEM_WB_PC_Out;
wire [63:0]  MEM_WB_a_mux;
wire MEM_WB_pc_wire;
wire MEM_WB_is_greater;
wire [4:0]rs1_store,rs2_store;
  
Mux m1 (normal_adder, EX_MEM_branch_adder, MEM_WB_pc_wire, PC_In); //PC src, deciding which pc_in to use 
Program_Counter p1 (clk,reset,PC_In, PC_Out); //Program counter taking in PC_in from the adders and giving a pc_out  
Adder a1 (PC_Out, 64'b100, normal_adder); //adder adding 4 to take to the next MEM_WB_instruction  
Instruction_Memory i1 (PC_Out,MEM_WB_instruction); //reading the MEM_WB_instruction  


IF_ID u1(clk,PC_Out,MEM_WB_instruction,MEM_WB_PC_Out,MEM_WB_ins); 
InsParser in1(MEM_WB_ins,opcode,rd,funct3,rs1,rs2,funct7); //decoding the MEM_WB_instruction  

wire [2:0]func3out;
assign Func[3] = MEM_WB_ins[30];  
assign Func[2:0] = MEM_WB_ins[14:12];
Control_Unit c1 (opcode,Branch, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite, ALUOp); //control unit giving the control signals  
ImmGen im1(MEM_WB_ins,imm_data);  //immediate generation of the immediate value   
registerFile r1 (WriteData,rs1,rs2,MEM_WB_rd,RegWrite, clk, reset,ReadData1,ReadData2);  //working in the register block  

  

ID_EX u2(clk,MEM_WB_PC_Out,ReadData1,ReadData2,imm_data,Func,funct3,rd,rs1,rs2,MemtoReg, RegWrite,Branch, MemWrite, MemRead,ALUSrc,ALUOp, ID_EX_PC_Out, ID_EX_ReadData1, ID_EX_ReadData2, ID_EX_imm_data, ID_EX_Func,func3out, ID_EX_rd, ID_EX_MemtoReg, ID_EX_RegWrite, ID_EX_Branch, ID_EX_MemWrite, ID_EX_MemRead, ID_EX_ALUSrc, ID_EX_ALUOp,rs1_store,rs2_store); 

  

assign imm= ID_EX_imm_data <<1;  
wire [63:0]  b_mux;
wire [1:0] fwd_A_out, fwd_B_out;
ALU_Control alu_c1 (ID_EX_ALUOp, ID_EX_Func,operation); //deciding the operation for alu  
mux_triple v3 (ID_EX_ReadData1,WriteData,EX_MEM_Result,fwd_A_out,MEM_WB_a_mux);
mux_triple v4 (ID_EX_ReadData2,WriteData,EX_MEM_Result,fwd_B_out,b_mux);
Mux m2 (b_mux, ID_EX_imm_data, ID_EX_ALUSrc, ALU_input2); //ALU src, deciding what goes to the alu  
ALU_64_bit_3 alu1 (MEM_WB_a_mux, ALU_input2,operation,func3out , Result, ZERO,MEM_WB_is_greater); //alu performing the said operation  

Forwarding_Unit v6(EX_MEM_EX_MEM_rd,MEM_WB_rd,rs1_store,rs2_store, EX_MEM_RegWrite, EX_MEM_MemtoReg,MEM_WB_RegWrite,fwd_A_out,fwd_B_out);

Adder a2 (ID_EX_PC_Out, imm, branch_adder); //adder adding in the branch value  


EX_MEM u3 (clk, ID_EX_RegWrite, ID_EX_MemtoReg, ID_EX_Branch, ZERO,MEM_WB_is_greater, ID_EX_MemWrite, ID_EX_MemRead,branch_adder, Result, ID_EX_ReadData2, ID_EX_Func, ID_EX_rd, EX_MEM_RegWrite, EX_MEM_MemtoReg, EX_MEM_Branch, EX_MEM_Zero,MEM_WB_is_greater1, EX_MEM_MemWrite, EX_MEM_MemRead,EX_MEM_branch_adder, EX_MEM_Result, EX_MEM_ReadData2,EX_MEM_Func,EX_MEM_EX_MEM_rd ); 
Branch_Control v8(EX_MEM_Branch,EX_MEM_Zero,MEM_WB_is_greater1,EX_MEM_Func,EX_MEM_Result,MEM_WB_pc_wire);
 
 

Data_Memory d1(EX_MEM_Result,EX_MEM_ReadData2, clk, EX_MEM_MemWrite, EX_MEM_MemRead,read_mem_data); //working with the data memeory  

MEM_WB u4(clk, EX_MEM_RegWrite, EX_MEM_MemtoReg,read_mem_data,EX_MEM_Result,EX_MEM_EX_MEM_rd,MEM_WB_RegWrite, MEM_WB_MemtoReg,MEM_WB_read_mem_data,MEM_WB_Result,MEM_WB_rd); 

  

Mux m3 ( MEM_WB_Result,MEM_WB_read_mem_data,MEM_WB_MemtoReg, WriteData); //deciding which data to write back  

endmodule
//`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////////
//// Company: 
//// Engineer: 
//// 
//// Create Date: 04/27/2023 02:24:56 PM
//// Design Name: 
//// Module Name: RISC_V_Processor
//// Project Name: 
//// Target Devices: 
//// Tool Versions: 
//// Description: 
//// 
//// Dependencies: 
//// 
//// Revision:
//// Revision 0.01 - File Created
//// Additional Comments:
//// 
////////////////////////////////////////////////////////////////////////////////////


//module RISC_V_Processor(  
//    input clk, reset,  
//    output wire [63:0] PC_In,  //prev inst add  
//    output wire [63:0] PC_Out,  //new ins add  
//    output wire [31:0] instruction,  //ins  
//    output wire [6:0] opcode, //opcode  
//    output wire [4:0] rs1,    output wire [4:0] rs2,  
//    output wire [4:0] rd,  
//    output wire [63:0] WriteData, //in rd  
//    output wire [63:0] ReadData1,  
//    output wire [63:0] ReadData2, //writedata (mem)  
//    output wire Branch, MemWrite, MemRead, MemtoReg,  
//    output wire [1:0] ALUOp,  
//    output wire ALUSrc, RegWrite,  
//    output wire [63:0] Result, //Mem_Add  
//    output wire [63:0] read_mem_data,  
//    output  wire [63:0]imm_data,  
//    output wire [3:0] operation,  
//    output wire ZERO,  
//    output wire [63:0] ALU_input2,  
//    output wire[63:0] branch_adder,  
//    output wire[63:0] imm
    

    

//);  

  

//wire [63:0] normal_adder;  
//wire [2:0] funct3;  
//wire [6:0] funct7;  
//wire [3:0] Func;  
////ID_EX wires
//wire [63:0] PC_Out2,ReadData11,ReadData21,imm_data1; 
//wire [3:0] Func1; 
//wire [4:0] rd1; 
//wire MemtoReg1, RegWrite1,Branch1, MemWrite1, MemRead1,ALUSrc1; 
//wire [1:0] ALUOp1; 
//wire [2:0] funct31; 
////EX_MEM wires
//wire RegWrite2, MemtoReg2, Branch2, Zero1, MemWrite2, MemRead2; 
//wire [63:0] branch_adder2, Result1, ReadData22;
//wire [3:0] Func2; 
//wire [4:0] rd2; 
////MEM_WB wires
//wire RegWrite3, MemtoReg3; 
//wire [63:0] read_mem_data2,Result2; 
//wire [4:0] rd3; 
//wire [31:0]  ins;
//wire [63:0] PC_Out1;
//wire [63:0]  a_mux;
//wire pc_wire;
//wire is_greater;

  
//Mux m1 (normal_adder, branch_adder2, pc_wire, PC_In); //PC src, deciding which pc_in to use 
//Program_Counter p1 (clk,reset,PC_In, PC_Out); //Program counter taking in PC_in from the adders and giving a pc_out  
//Adder a1 (PC_Out, 64'b100, normal_adder); //adder adding 4 to take to the next instruction  
//Instruction_Memory i1 (PC_Out,instruction); //reading the instruction  

  

  

  

//IF_ID u1(clk,PC_Out,instruction,PC_Out1,ins); 
//InsParser in1(ins,opcode,rd,funct3,rs1,rs2,funct7); //decoding the instruction  

//wire [2:0]func3out;
//assign Func[3] = ins[30];  
//assign Func[2:0] = ins[14:12];
//Control_Unit c1 (opcode,Branch, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite, ALUOp); //control unit giving the control signals  
//ImmGen im1(ins,imm_data);  //immediate generation of the immediate value   
//registerFile r1 (WriteData,rs1,rs2,rd3,RegWrite, clk, reset,ReadData1,ReadData2);  //working in the register block  

  

//ID_EX u2(clk,PC_Out1,ReadData1,ReadData2,imm_data,Func,funct3,rd,rs1,rs2,MemtoReg, RegWrite,Branch, MemWrite, MemRead,ALUSrc,ALUOp,PC_Out2,ReadData11,ReadData21,imm_data1,Func1,func3out,rd1,MemtoReg1, RegWrite1,Branch1, MemWrite1, MemRead1,ALUSrc1,ALUOp1,rs1_store,rs2_store); 

  

//assign imm=imm_data1<<1;  
//wire [63:0]  b_mux;
//wire [1:0] fwd_A_out, fwd_B_out;
//ALU_Control alu_c1 (ALUOp1, Func1,operation); //deciding the operation for alu  
//mux_triple v3 (ReadData11,WriteData,Result1,fwd_A_out,a_mux);
//mux_triple v4 (ReadData21,WriteData,Result1,fwd_B_out,b_mux);
//Mux m2 (b_mux,imm_data1, ALUSrc1, ALU_input2); //ALU src, deciding what goes to the alu  
//ALU_64_bit_3 alu1 (a_mux, ALU_input2,operation,func3out , Result, ZERO,is_greater); //alu performing the said operation  

//Forwarding_Unit v6(rd2,rd3,rs1_store,rs2_store,RegWrite2, MemtoReg2,RegWrite3,fwd_A_out,fwd_B_out);

//Adder a2 (PC_Out2, imm, branch_adder); //adder adding in the branch value  


//EX_MEM u3 (clk,RegWrite1, MemtoReg1, Branch1, ZERO,is_greater, MemWrite1, MemRead1,branch_adder, Result, ReadData21,Func1,rd1,RegWrite2, MemtoReg2, Branch2, Zero1,is_greater1, MemWrite2, MemRead2,branch_adder2, Result1, ReadData22,Func2,rd2 ); 
//Branch_Control v8(Branch2,Zero1,is_greater1,Func2,Result1,pc_wire);
 
 

//Data_Memory d1(Result1,ReadData22, clk, MemWrite2, MemRead2,read_mem_data); //working with the data memeory  

//MEM_WB u4(clk,RegWrite2, MemtoReg2,read_mem_data,Result1,rd2,RegWrite3, MemtoReg3,read_mem_data2,Result2,rd3); 

  

//Mux m3 ( Result2,read_mem_data2,MemtoReg3, WriteData); //deciding which data to write back  

//endmodule  


