`timescale 1ns/1ps
module segDriver(
    input clk,
    input rst,
    input enable,
    input[23:0] num,
    output reg[7:0] seg,
    output reg[7:0] seg1,
    output reg[7:0] an
);
    parameter maxcnt = 50000;
    reg[29:0] cntclk_cnt = 0;
    reg cntclk = 0;
    parameter maxclk = 30'd50000000;
   
    
    
    
    reg[18:0] divclk_cnt = 0;
    reg divclk = 0;
    reg[3:0] disp_dat = 0;
    reg[2:0] disp_bit = 0;
    reg[3:0] res1 = 0;
    reg[3:0] res2 = 0;
    reg[3:0] res3 = 0;
    reg[3:0] res4 = 0;
    reg[3:0] res5 = 0;
    reg[3:0] res6 = 0;
    reg[3:0] res7 = 0;
    reg[3:0] res8 = 0;
    integer i;
    always @(posedge cntclk) begin
        res1 = 0;
        res2 = 0;
        res3 = 0;
        res4 = 0;
        res5 = 0;
        res6 = 0;
        res7 = 0;
        res8 = 0;
        for (i = 23; i >= 0; i = i - 1) begin
            if (res1 >= 4'd5) res1 = res1 + 4'd3;
            if (res2 >= 4'd5) res2 = res2 + 4'd3;
            if (res3 >= 4'd5) res3 = res3 + 4'd3;
            if (res4 >= 4'd5) res4 = res4 + 4'd3;
            if (res5 >= 4'd5) res5 = res5 + 4'd3;
            if (res6 >= 4'd5) res6 = res6 + 4'd3;
            if (res7 >= 4'd5) res7 = res7 + 4'd3;
            if (res8 >= 4'd5) res8 = res8 + 4'd3;
            res8 = {res8[2:0],res7[3]};
            res7 = {res7[2:0], res6[3]};
            res6 = {res6[2:0], res5[3]};
            res5 = {res5[2:0], res4[3]};
            res4 = {res4[2:0], res3[3]};
            res3 = {res3[2:0], res2[3]};
            res2 = {res2[2:0], res1[3]};
            res1 = {res1[2:0], num[i]};
        end
    end
    
    
    always @(posedge clk) begin
        if (divclk_cnt == maxcnt) begin
            divclk = ~divclk;
            divclk_cnt = 0;
        end
        else divclk_cnt = divclk_cnt + 1'b1;
        if (cntclk_cnt == maxclk) begin
            cntclk = ~cntclk;
            cntclk_cnt = 0;
        end
        else cntclk_cnt = cntclk_cnt + 1'b1;
    end
    
    
    always @(posedge divclk) begin
        disp_bit = (disp_bit >= 7) ? 1'b0 : disp_bit + 1'b1;
        case (disp_bit)
            3'b000: begin
                disp_dat = (enable == 1'b0) ? 4'hf : res1;
                an = 8'b00000001;
            end
            3'b001: begin
                disp_dat = (enable == 1'b0) ? 4'hf : res2;
                an = 8'b00000010;
            end
            3'b010: begin
                disp_dat = (enable == 1'b0) ? 4'hf : res3;
                an = 8'b00000100;
            end
            3'b011: begin
                disp_dat = (enable == 1'b0) ? 4'hf : res4;
                an = 8'b00001000;
            end
            3'b100: begin
                disp_dat = (enable == 1'b0) ? 4'hf : res5;
                an = 8'b00010000;
            end
            3'b101: begin
                disp_dat = (enable == 1'b0) ? 4'hf : res6;
                an = 8'b00100000;
            end
            3'b110: begin
                disp_dat = (enable == 1'b0) ? 4'hf : res7;
                an = 8'b01000000;
            end
            3'b111: begin
                disp_dat = (enable == 1'b0) ? 4'hf : res8;
                an = 8'b10000000;
            end
            default: begin
                disp_dat = 0;
                an = 8'b00000000;
            end
        endcase
    end
    always @(disp_dat) begin
        if (an > 8'b00001000) begin
            case (disp_dat)
                4'h0 : seg = 8'hfc;
                4'h1 : seg = 8'h60;
                4'h2 : seg = 8'hda;
                4'h3 : seg = 8'hf2;
                4'h4 : seg = 8'h66;
                4'h5 : seg = 8'hb6;
                4'h6 : seg = 8'hbe;
                4'h7 : seg = 8'he0;
                4'h8 : seg = 8'hfe;
                4'h9 : seg = 8'hf6;
                4'ha : seg = 8'hee;
                4'hb : seg = 8'h3e;
                4'hc : seg = 8'h9c;
                4'hd : seg = 8'h7a;
                4'he : seg = 8'h9e;
                4'hf : seg = 8'h8e;
            endcase
        end
        else begin
            case (disp_dat)
                4'h0 : seg1 = 8'hfc;
                4'h1 : seg1 = 8'h60;
                4'h2 : seg1 = 8'hda;
                4'h3 : seg1 = 8'hf2;
                4'h4 : seg1 = 8'h66;
                4'h5 : seg1 = 8'hb6;
                4'h6 : seg1 = 8'hbe;
                4'h7 : seg1 = 8'he0;
                4'h8 : seg1 = 8'hfe;
                4'h9 : seg1 = 8'hf6;
                4'ha : seg1 = 8'hee;
                4'hb : seg1 = 8'h3e;
                4'hc : seg1 = 8'h9c;
                4'hd : seg1 = 8'h7a;
                4'he : seg1 = 8'h9e;
                4'hf : seg1 = 8'h8e;
            endcase
        end
    end

endmodule
