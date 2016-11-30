----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    00:04:31 11/29/2016 
-- Design Name: 
-- Module Name:    mycpu - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL ;
use IEEE.STD_LOGIC_UNSIGNED.ALL ;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity mycpu is
	port(
			rst : in std_logic; --reset
			clk : in std_logic; --时钟源  默认为50M  可以通过修改绑定管教来改变
			
			--串口
			dataReady : in std_logic;   
			tbre : in std_logic;
			tsre : in std_logic;
			rdn : inout std_logic;
			wrn : inout std_logic;
			
			--RAM1  存放数据
			ram1En : out std_logic;
			ram1We : out std_logic;
			ram1Oe : out std_logic;
			ram1Data : inout std_logic_vector(15 downto 0);
			ram1Addr : out std_logic_vector(17 downto 0);
			
			--RAM2 存放程序和指令
			ram2En : out std_logic;
			ram2We : out std_logic;
			ram2Oe : out std_logic;
			ram2Data : inout std_logic_vector(15 downto 0);
			ram2Addr : out std_logic_vector(17 downto 0);
			
			--debug  digit1、digit2显示PC值，led显示当前指令的编码
			digit1 : out std_logic_vector(6 downto 0);
			digit2 : out std_logic_vector(6 downto 0);
			led : out std_logic_vector(15 downto 0);
			
			hs,vs : out std_logic;
			redOut, greenOut, blueOut : out std_logic_vector(2 downto 0)
	);
end mycpu;

architecture Behavioral of mycpu is
	component clock is
		port(
			rst : in std_logic;
			clkIn : in std_logic;

			clk2 : out std_logic;
			clk4 : out std_logic
		);
	end component;

	component ALU
		Port ( Op1 : in  STD_LOGIC_VECTOR (15 downto 0);
           Op2 : in  STD_LOGIC_VECTOR (15 downto 0);
           Op : in  STD_LOGIC_VECTOR (3 downto 0);
           result : out  STD_LOGIC_VECTOR (15 downto 0)
			  );
	end component;

	component IO
		port(
			rst 			: in std_logic;
			clk 			: in std_logic;
			MemWrite		: in std_logic;
			MemRead			: in std_logic;
			data		: in std_logic_vector(15 downto 0);--WriteData  IN
			addr		: in std_logic_vector(15 downto 0);--MemAddr IN
			pcaddr		: in std_logic_vector(15 downto 0);	
			MemData		: out std_logic_vector(15 downto 0);--MemData OUT
			PC			: out std_logic_vector(15 downto 0);--PC OUT
			tbre			: in std_logic;
			tsre			: in std_logic;
			rdn 			: inout std_logic;
			wrn				: inout std_logic;
			data_ready		: in std_logic;
			ram1_en 		: out std_logic;
			ram1_oe			: out std_logic;
			ram1_we			: out std_logic;
			ram1_addr		: out std_logic_vector(17 downto 0);
			ram1_data		: inout std_logic_vector(15 downto 0);
			ram2_en			: out std_logic;
			ram2_oe			: out std_logic;
			ram2_we			: out std_logic;
			ram2_addr		: out std_logic_vector(17 downto 0);
			ram2_data		: inout std_logic_vector(15 downto 0)		
		);
	end component;

	component PCAddim
		port(
			NextPC : in std_logic_vector(15 downto 0);
			imme : in std_logic_vector(15 downto 0);

			PCim : out std_logic_vector(15 downto 0)
		);		
	end component;

	component RyMux 
		port(
			Ry : in std_logic_vector(15 downto 0);
			WBData : in std_logic_vector(15 downto 0);
			MemData : in std_logic_vector(15 downto 0);
			
			Forward2 : in std_logic_vector(1 downto 0);
			
			RyOut : out std_logic_vector(15 downto 0)
		);
	end component;

	component SecondOpMux
	port(
			Ry : in std_logic_vector(15 downto 0);
			imme : in std_logic_vector(15 downto 0);
			AluSrc : in std_logic;
			
			SecondOp : out std_logic_vector(15 downto 0)
	);
	end component;

	component MemWbRegisters 
		port(
			clk : in std_logic;
			rst : in std_logic;
			
			MemData : in std_logic_vector(15 downto 0);
			MemAluRes : in std_logic_vector(15 downto 0);
			MemRd : in std_logic_vector(3 downto 0);
			
			MemRegWrite : in std_logic;--控制信号
			MemtoReg : in std_logic;--控制信号，内部使用
			
			WBRd : out std_logic_vector(3 downto 0);
			RegWrite : out std_logic;
			WBData : out std_logic_vector(15 downto 0)
		);
	end component;

	component ImmExtend
	port(
			 immIn : in std_logic_vector(10 downto 0);
			 immSele : in std_logic_vector(2 downto 0);
			 
			 immOut : out std_logic_vector(15 downto 0)
		);
	end component;

	component IDExRegisters
		port(
			clk : in std_logic;
			rst : in std_logic;

			RxAddr : in std_logic_vector(3 downto 0);
			RyAddr : in std_logic_vector(3 downto 0);
			Rx : in std_logic_vector(15 downto 0);
			Ry : in std_logic_vector(15 downto 0);
			imme : in std_logic_vector(15 downto 0);
			IDPCAddimme : in std_logic_vector(15 downto 0);

			IDExFlush : in std_logic;
			IDControl : in std_logic_vector(4 downto 0) ;
			IDBJOp : in std_logic_vector(2 downto 0);

			Command : in std_logic_vector(15 downto 0);
			IDAluOp : in std_logic_vector(3 downto 0);
			IDRd : in std_logic_vector(3 downto 0);

			ExRd : out std_logic_vector(3 downto 0);
			Eximme : out std_logic_vector(15 downto 0);
			ExRxAddr : out std_logic_vector(3 downto 0);
			ExRyAddr : out std_logic_vector(3 downto 0);
			ExRx : out std_logic_vector(15 downto 0);
			ExRy : out std_logic_vector(15 downto 0);
			AluOp : out std_logic_vector(3 downto 0);
			ExBJOp : out std_logic_vector(2 downto 0);
			ExPCAddimme : out std_logic_vector(15 downto 0);

			AluSrc : out std_logic;
			EXMemWrite : out std_logic;
			ExMemRead : out std_logic;
			ExMemtoReg : out std_logic;
			ExRegWrite : out std_logic
		);
	end component;

	component ForwardUnit is
		port(
			MemRd : in std_logic_vector(3 downto 0);
			WBRd : in std_logic_vector(3 downto 0);
			ExRx : in std_logic_vector(3 downto 0);
			ExRy : in std_logic_vector(3 downto 0);
			
			MemRegWrite : in std_logic;
			WBRegWrite : in std_logic;
			
			
			Forward1 : out std_logic_vector(1 downto 0);
			Forward2 : out std_logic_vector(1 downto 0)
		);
	end component;


	component BJController
		port(
			Rx : in std_logic_vector(15 downto 0);
			BJOp : in std_logic_vector(2 downto 0);
			
			IFIDFlush : out std_logic;
			IDEXFlush : out std_logic;
			PCSrc : out std_logic_vector(1 downto 0)
		);
	end component;

	component ConflictController 
		port(
			ExMemRead : in std_logic;
			ExRd : in std_logic_vector(3 downto 0);
			
			RxAddr : in std_logic_vector(3 downto 0);
			RyAddr : in std_logic_vector(3 downto 0);
			
			PCKeep : out std_logic;
			IFIDKeep : out std_logic;
			Cto0 : out std_logic
		);		
	end component;

	component ExMemRegisters
		port(
			clk : in std_logic;
			rst : in std_logic;
			
			ExData : in std_logic_vector(15 downto 0);
			ExRd : in std_logic_vector(3 downto 0);
			AluRes : in std_logic_vector(15 downto 0);
			
			ExRegWrite : in std_logic;
			ExMemRead : in std_logic;
			ExMemWrite : in std_logic;
			ExMemtoReg : in std_logic;

			Addr : out std_logic_vector(15 downto 0);
			Data : out std_logic_vector(15 downto 0);
			MemRd : out std_logic_vector(3 downto 0);
			MemAluRes : out std_logic_vector(15 downto 0);

			
			MemWrite : out std_logic;
			MemRead : out std_logic;
			MemRegWrite : out std_logic;
			MemtoReg : out std_logic
		);
	end component;

	component FirstOpMux
		port(
			Rx : in std_logic_vector(15 downto 0);
			WBData : in std_logic_vector(15 downto 0);
			MemData : in std_logic_vector(15 downto 0);
			
			Forward1 : in std_logic_vector(1 downto 0);
			
			FirstOp : out std_logic_vector(15 downto 0)
		);
	end component;

	component Controller
		port(	
			commandIn : in std_logic_vector(15 downto 0);
			rst : in std_logic;
			imm : out std_logic_vector(2 downto 0);
			controllerOut :  out std_logic_vector(4 downto 0) ;
			-- RegWrite(1) ALUSrc(1) MemRead(1)MemWrite(1)MemtoReg(1)
			Rd : out std_logic_vector(3 downto 0);
			ALUOp : out std_logic_vector(3 downto 0);
			rx : out std_logic_vector(3 downto 0);
			ry : out std_logic_vector(3 downto 0);
			BJOp : out std_logic_vector(2 downto 0)
			);
	end component;

	--component TRegisters
	--	port(
	--		rst : in std_logic;
	--		dataA : in std_logic_vector(15 downto 0);
	--		dataB : in std_logic_vector(15 downto 0);
	--		TOp : in std_logic_vector(1 downto 0);
	--		dataImme : in std_logic_vector(15 downto 0);
			
	--		dataT : out std_logic
	--	);
	--end component;

	component ControllerMux
		port(
			controllerin : in std_logic_vector(4 downto 0);
			CTo0 : in std_logic;
			controllerout : out std_logic_vector(4 downto 0)
		);
	end component;

	component PCMux
		port( 
			PCSrc : in std_logic_vector(1 downto 0);
			PCImme : in std_logic_vector(15 downto 0);
			PCFour : in std_logic_vector(15 downto 0);
			PCRx : in std_logic_vector(15 downto 0);
			
			PCNext : out std_logic_vector(15 downto 0)
			);
	end component;

	component Registers
		port(
			clk : in std_logic;
			rst : in std_logic;
			rx : in std_logic_vector(3 downto 0);
			ry : in std_logic_vector(3 downto 0);
			WbRd : in std_logic_vector(3 downto 0);
			WbData : in std_logic_vector(15 downto 0);
			PCIn : in std_logic_vector(15 downto 0);
			RegWrite : in std_logic;
			
		
			r0Out, r1Out, r2Out,r3Out,r4Out,r5Out,r6Out,r7Out : out std_logic_vector(15 downto 0);
			dataA : out std_logic_vector(15 downto 0);
			dataB : out std_logic_vector(15 downto 0);
			dataSP : out std_logic_vector(15 downto 0);
			dataIH : out std_logic_vector(15 downto 0)
		);
	end component;

	component IfIdRegisters
		port(
			rst : in std_logic;
			clk : in std_logic;
			commandIn : in std_logic_vector(15 downto 0);
			PCFour : in std_logic_vector(15 downto 0); 
			IfIdKeep : in std_logic;
			IfIdFlush : in std_logic;
			
			imme : out std_logic_vector(10 downto 0);
				
			commandOut : out std_logic_vector(15 downto 0);
			PCOut : out std_logic_vector(15 downto 0)
		);
	end component;

	component PCAdder
		port( 	PCALUIn : in std_logic_vector(15 downto 0);
				PCALUOut : out std_logic_vector(15 downto 0)
			);
	end component;

	component PCRegister
		port(	rst : in std_logic;
				PCWrite : in std_logic;
				PCIn : in std_logic_vector(15 downto 0);
				PCOut : out std_logic_vector(15 downto 0)
			);
	end component;

	signal idpcaddimme : std_logic_vector(15 downto 0);--come from pcaddim
	signal expcaddimme : std_logic_vector(15 downto 0);--pc mux in
	signal pcsrc     : std_logic_vector(1 downto 0);--come from BJController
	signal pcmuxout     : std_logic_vector(15 downto 0);
	signal clk2		 : std_logic;
	signal clk4		 : std_logic;
	signal pcwrite   : std_logic;--come from ConflictController(pcregister in)
	signal pcrout      : std_logic_vector(15 downto 0);--pc register out
	signal pcadderout  : std_logic_vector(15 downto 0);--pc adder out
	signal ifcommand : std_logic_vector(15 downto 0);--come from io
	signal ifidkeep : std_logic;--come from BJController
	signal ifidflush : std_logic;--come from BJController

	--id
	signal idimme   : std_logic_vector(10 downto 0);--come from ifidregister (immextend in)
	signal idimme16 : std_logic_vector(15 downto 0);--come from immextend
	signal idcommand : std_logic_vector(15 downto 0);--come from ifidregister (controller in)(idexregisters in)
	signal idpc : std_logic_vector(15 downto 0);--ifidregisters out (pcmux in) (registers in) (pcaddim in)
	signal immsele : std_logic_vector(2 downto 0);--controller out(immextend in)--controller out
	signal controlsignal : std_logic_vector(4 downto 0);--controller out
	signal idcontrol : std_logic_vector(4 downto 0);--controllermux out
	signal idrd : std_logic_vector(3 downto 0);
	signal idaluop : std_logic_vector(3 downto 0);
	signal idrxaddr : std_logic_vector(3 downto 0);--Registers in
	signal idryaddr : std_logic_vector(3 downto 0);--Registers in
	signal idbjop : std_logic_vector(2 downto 0);
	signal idrx : std_logic_vector(15 downto 0);--come from registers
	signal idry : std_logic_vector(15 downto 0);--come from registers
	signal idt : std_logic;--come from TRegisters
	signal idcto0 : std_logic;--ConflictController out
	signal idexflush : std_logic;

	--ex
	signal exrd : std_logic_vector(3 downto 0);	
	signal eximme : std_logic_vector(15 downto 0);
	signal exrxaddr : std_logic_vector(3 downto 0);
	signal exryaddr : std_logic_vector(3 downto 0);
	signal exrx : std_logic_vector(15 downto 0);
	signal exry : std_logic_vector(15 downto 0);
	signal exaluop : std_logic_vector(3 downto 0);
	signal exdata : std_logic_vector(15 downto 0);
	signal exalusrc : std_logic;
	signal exmemread : std_logic;--ConflictController in
	signal exmemwrite : std_logic;
	signal exmemtoreg : std_logic;
	signal exregwrite : std_logic;
	signal forward1 : std_logic_vector(1 downto 0);
	signal forward2 : std_logic_vector(1 downto 0);
	signal firstop : std_logic_vector(15 downto 0);
	signal secondop : std_logic_vector(15 downto 0);
	signal newexry : std_logic_vector(15 downto 0);
	signal exalures : std_logic_vector(15 downto 0);
	signal exbjop : std_logic_vector(2 downto 0);

	--mem
	signal memalures : std_logic_vector(15 downto 0);
	signal memaddr : std_logic_vector(15 downto 0);
	signal writedata : std_logic_vector(15 downto 0);
	signal memrd : std_logic_vector(3 downto 0);
	signal memread : std_logic;
	signal memwrite : std_logic;
	signal memregwrite : std_logic;
	signal memtoreg : std_logic;
	signal memdata : std_logic_vector(15 downto 0);


	signal wbrd : std_logic_vector(3 downto 0);--Registers in
	signal wbdata : std_logic_vector(15 downto 0);--Registers in(firstopmux in)
	signal wbregwrite : std_logic;--Registers in




	signal r0,r1,r2,r3,r4,r5,r6,r7 : std_logic_vector(15 downto 0);--(debug)


begin
u1 : clock
	port map(	
		rst => rst,
		clkIn => clk,
		--out
		clk2 => clk2,
		clk4 => clk4
	);

u2 : PCMux                             
	port map(	
		PCSrc => pcsrc,
		PCImme => expcaddimme,
		PCFour => idpc,
		PCRx => firstop,
		--out
		PCNext => pcmuxout --pc register in
	);

u3 : PCRegister
	port map(
		rst => rst,
		PCWrite => pcwrite,
		PCIn => pcmuxout,
		--out
		PCOut => pcrout --IF PC
	);

u4 : PCAdder
	port map(
		PCALUIn => pcrout,
		--out
		PCALUOut => pcadderout
	);

u5 : IfIdRegisters
	port map(
		rst => rst,
		clk => clk4,
		commandIn => ifcommand,

		PCFour => pcadderout,
		IfIdKeep => ifidkeep,
		IfIdFlush => ifidflush,
		--out
		imme => idimme,		
		commandOut =>idcommand,
		PCOut => idpc
	);

u6 : Controller
	port map(
		commandIn => idcommand,
		rst => rst,
		--out
		imm => immsele,
		controllerOut => controlsignal,
		-- RegWrite(1) ALUSrc(1) MemRead(1)MemWrite(1)MemtoReg(1)
		Rd => idrd,
		ALUOp => idaluop,

		rx => idrxaddr,
		ry => idryaddr,
		BJOp => idbjop
	);

u7 : ImmExtend
	port map(
		immIn => idimme,
		immSele => immsele,
		--out
		immOut =>idimme16
	);

u8 : PCAddim
	port map(
		NextPC => idpc,
		imme => idimme16,
		--out
		PCim => idpcaddimme
	);

u9 : Registers
	port map(
		clk => clk2,
		rst => rst,
		rx => idrxaddr,
		ry => idryaddr,
		WbRd => wbrd,
		WbData => wbdata,
		PCIn => idpc,
		RegWrite => wbregwrite,
		--out
		r0Out => r0,
		r1Out => r1,
		r2Out => r2,
		r3Out => r3,
		r4Out => r4,
		r5Out => r5,
		r6Out => r6,
		r7Out => r7,
			
		dataA => idrx,
		dataB => idry,
		dataSP => open,
		dataIH => open
	);

--u10 : TRegisters
--	port map(
--		rst => rst,
--		dataA => idrx,
--		dataB => idry,
--		TOp => idtop,
--		dataImme => idimme16,
--		--out
--		dataT => idt
--	);

u11 : BJController
	port map(
		Rx => firstop,
		--T => idt,
		BJOp => exbjop,
		--out
		IFIDFlush => ifidflush,
		IDEXFlush => idexflush,
		PCSrc => pcsrc
		
	);

u12 : ConflictController
	port map(
		ExMemRead => exmemread,
		ExRd => exrd,
			
		RxAddr => idrxaddr,
		RyAddr => idryaddr,
		--out
		PCKeep => pcwrite,
		IFIDKeep => ifidkeep,
		Cto0 => idcto0
	);

u13 : ControllerMux
	port map(
		controllerin => controlsignal,
		CTo0 => idcto0,
		--out
		controllerout =>idcontrol
	);

u14 : IDExRegisters
	port map(
		clk => clk4,
		rst => rst,
		RxAddr => idrxaddr,
		RyAddr => idryaddr,
		Rx => idrx,
		Ry => idry,
		imme => idimme16,
		IDPCAddimme => idpcaddimme,

		IDExFlush => idexflush,
		IDControl => idcontrol,
		-- RegWrite(0) ALUSrc(1) MemRead(2)MemWrite(3)MemtoReg(4)
		Command => idcommand,
		IDAluOp => idaluop,
		IDBJOp => idbjop,
		IDRd => idrd,
		--out
		ExRd => exrd,
		Eximme => eximme,
		ExRxAddr =>exrxaddr,
		ExRyAddr =>exryaddr,
		ExRx =>exrx,
		ExRy =>exry,
		AluOp =>exaluop,
		ExBJOp => exbjop,
		ExPCAddimme => expcaddimme,

		AluSrc =>exalusrc,
		EXMemWrite =>exmemwrite,
		ExMemRead => exmemread,
		ExMemtoReg => exmemtoreg,
		ExRegWrite => exregwrite
	);

u15 : FirstOpMux
	port map(
		Rx => exrx,
		WBData => wbdata,
		MemData => memalures,
		--out
		Forward1 => forward1,
		FirstOp => firstop
	);

u16 : RyMux
	port map(
		Ry => exry,
		WBData =>wbdata,
		MemData =>memalures,
		--out
		Forward2 => forward2,
			
		RyOut => newexry
	);

u17 : SecondOpMux
	port map(
		Ry => newexry,
		imme => eximme,
		AluSrc => exalusrc,
		--out
		SecondOp => secondop
	);

u18 : Alu
	port map(
		Op1 =>firstop,
        Op2 =>secondop,
        Op =>exaluop,
        --out
        result => exalures
	);

u19 : ExMemRegisters
	port map(
		clk => clk4,
		rst => rst,

		ExData => newexry,
		ExRd => exrd,
		AluRes => exalures,

		ExRegWrite => exregwrite,
		ExMemRead => exmemread,
		ExMemWrite => exmemwrite,
		ExMemtoReg => exmemtoreg,

		Addr => memaddr,
		Data => writedata,
		MemRd => memrd,
		MemAluRes => memalures,

		MemRegWrite => memregwrite,
		MemWrite => memwrite,
		MemRead => memread,
		MemtoReg => memtoreg
	);

u20 : IO
	port map(
		rst => rst,
		clk => clk,

		MemWrite => memwrite,
		MemRead	=> memread,
		data	=>writedata,--WriteData  IN
		addr	=>memaddr,--MemAddr IN
		pcaddr	=>pcrout,
		--out
		MemData		=>memdata,--MemData OUT
		PC			=>ifcommand, --PC OUT

		tbre		=>tbre,
		tsre		=>tsre,
		rdn 		=>rdn,
		wrn			=>wrn,
		data_ready	=>dataReady,

		ram1_en 	=>ram1En,
		ram1_oe		=>ram1Oe,
		ram1_we		=>ram1We,
		ram1_addr	=>ram1Addr,
		ram1_data	=>ram1Data,

		ram2_en		=>ram2En,
		ram2_oe		=>ram2Oe,
		ram2_we		=>ram2We,
		ram2_addr	=>ram2Addr,
		ram2_data	=>ram2Data
	);

u21 : MemWbRegisters
	port map(
		clk =>clk4,
		rst =>rst,
			
		MemData => memdata,
		MemAluRes => memalures,
		MemRd => memrd,
			
		MemRegWrite => memregwrite,
		MemtoReg => memtoreg,
		--out
		WBRd => wbrd,
		RegWrite => wbregwrite,
		WBData => wbdata
	);

u22 : ForwardUnit
	port map(
		MemRd =>memrd,
		WBRd =>wbrd,
		ExRx =>exrxaddr,
		ExRy =>exryaddr,
		
		MemRegWrite => memregwrite,
		WBRegWrite => wbregwrite,
			
		--out
		Forward1 => forward1,
		Forward2 => forward2
	);
	
	
	
	--led <=wbdata;
	led <= ifcommand;
	--jing <= PCOut;
	process(pcadderout)
		begin
		case pcadderout(7 downto 4) is
			when "0000" => digit1 <= "0111111";--0
			when "0001" => digit1 <= "0000110";--1
			when "0010" => digit1 <= "1011011";--2
			when "0011" => digit1 <= "1001111";--3
			when "0100" => digit1 <= "1100110";--4
			when "0101" => digit1 <= "1101101";--5
			when "0110" => digit1 <= "1111101";--6
			when "0111" => digit1 <= "0000111";--7
			when "1000" => digit1 <= "1111111";--8
			when "1001" => digit1 <= "1101111";--9
			when "1010" => digit1 <= "1110111";--A
			when "1011" => digit1 <= "1111100";--B
			when "1100" => digit1 <= "0111001";--C
			when "1101" => digit1 <= "1011110";--D
			when "1110" => digit1 <= "1111001";--E
			when "1111" => digit1 <= "1110001";--F
			when others => digit1 <= "0000000";
		end case;
		
		case pcadderout(3 downto 0) is
			when "0000" => digit2 <= "0111111";--0
			when "0001" => digit2 <= "0000110";--1
			when "0010" => digit2 <= "1011011";--2
			when "0011" => digit2 <= "1001111";--3
			when "0100" => digit2 <= "1100110";--4
			when "0101" => digit2 <= "1101101";--5
			when "0110" => digit2 <= "1111101";--6
			when "0111" => digit2 <= "0000111";--7
			when "1000" => digit2 <= "1111111";--8
			when "1001" => digit2 <= "1101111";--9
			when "1010" => digit2 <= "1110111";--A
			when "1011" => digit2 <= "1111100";--B
			when "1100" => digit2 <= "0111001";--C
			when "1101" => digit2 <= "1011110";--D
			when "1110" => digit2 <= "1111001";--E
			when "1111" => digit2 <= "1110001";--F
			when others => digit2 <= "0000000";
		end case;
	end process;
	--ram1Addr <= (others => '0');
	hs<='0';
	vs<='0';
	redOut<="000";
	greenOut<="000";
	blueOut<="000";
end Behavioral;

