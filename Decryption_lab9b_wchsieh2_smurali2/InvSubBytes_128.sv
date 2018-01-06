module InvSubBytes_128 (input clk,
								input [0:127] in,
								output [0:127] out);
							
InvSubBytes Sub0(.*, .in(in[0:7]),.out(out[0:7]));
InvSubBytes Sub1(.*, .in(in[8:15]),.out(out[8:15]));
InvSubBytes Sub2(.*, .in(in[16:23]),.out(out[16:23]));
InvSubBytes Sub3(.*, .in(in[24:31]),.out(out[24:31]));
InvSubBytes Sub4(.*, .in(in[32:39]),.out(out[32:39]));
InvSubBytes Sub5(.*, .in(in[40:47]),.out(out[40:47]));
InvSubBytes Sub6(.*, .in(in[48:55]),.out(out[48:55]));
InvSubBytes Sub7(.*, .in(in[56:63]),.out(out[56:63]));
InvSubBytes Sub8(.*, .in(in[64:71]),.out(out[64:71]));
InvSubBytes Sub9(.*, .in(in[72:79]),.out(out[72:79]));
InvSubBytes Sub10(.*,.in(in[80:87]),.out(out[80:87]));
InvSubBytes Sub11(.*,.in(in[88:95]),.out(out[88:95]));
InvSubBytes Sub12(.*,.in(in[96:103]),.out(out[96:103]));
InvSubBytes Sub13(.*,.in(in[104:111]),.out(out[104:111]));
InvSubBytes Sub14(.*,.in(in[112:119]),.out(out[112:119]));
InvSubBytes Sub15(.*,.in(in[120:127]),.out(out[120:127]));

endmodule