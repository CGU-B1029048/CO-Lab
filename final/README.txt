* 無論是要synthesize circuit或run simulation waveform都請設"Top.v"為top-level module
* Testbench檔案為"Top_tb.v"；Test bench name請填"Top_tb"。另外Design Instance請設"DUT"

需要改的檔案：
1. CPU.v中請把Lab7的datapath接進去，把原本case(Opcode)那段和其他多餘的code拿掉，並實做control unit中需要的circuit
2. imem.txt中請放入demo要用的指令
3. dmem.txt中請放入需要用的data

請參考課本Ch. 8-8
M. Morris Mano, “Logic and Computer Design Fundamentals,” 5/e, Prentice Hall, 2018

credit to Prof. Yung-Cheng Ma