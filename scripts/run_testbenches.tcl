# Compile the testbenches
vcom -2008 path/to/module1_tb1.vhd
vcom -2008 path/to/module1_tb2.vhd
vcom -2008 path/to/module2_tb1.vhd
vcom -2008 path/to/module2_tb2.vhd
vcom -2008 path/to/module3_tb1.vhd
vcom -2008 path/to/module3_tb2.vhd
vcom -2008 path/to/module4_tb1.vhd
vcom -2008 path/to/module4_tb2.vhd
vcom -2008 path/to/module5_tb1.vhd
vcom -2008 path/to/module5_tb2.vhd

# Run each testbench
run_test "module1_tb1"
run_test "module1_tb2"
run_test "module2_tb1"
run_test "module2_tb2"
run_test "module3_tb1"
run_test "module3_tb2"
run_test "module4_tb1"
run_test "module4_tb2"
run_test "module5_tb1"
run_test "module5_tb2"

# Generate test results in JUnit XML format
proc run_test { tb_name } {
    vsim -c work.$tb_name -do "run -all; quit"
    # Export the test results to a file (customize the output file paths)
    write_junit_xml "test_results/$tb_name.xml"
}

# Utility procedure to convert test results to JUnit XML (can be implemented as needed)
proc write_junit_xml {file_path} {
    # Write the results to XML file (you may need a custom script or plugin for this)
}
