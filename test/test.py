import cocotb
from cocotb.triggers import RisingEdge

@cocotb.test()
async def test_project(dut):
    dut.ui_in.value = 0
    dut.ena.value = 1
    dut.rst_n.value = 0

    # Wait for a clock cycle
    await RisingEdge(dut.clk)
    dut.rst_n.value = 1  # Release reset

    # Apply some test stimulus
    dut.ui_in.value = 0b00001111
    await RisingEdge(dut.clk)
    
    dut.ui_in.value = 0b11110000
    await RisingEdge(dut.clk)
    
    dut.ui_in.value = 0b10101010
    await RisingEdge(dut.clk)
