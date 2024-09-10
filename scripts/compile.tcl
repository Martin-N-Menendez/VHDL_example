# Create the work library if it doesn't exist
puts "Creating work library..."
vlib work
vmap work work
puts "Work library created."

# Compile VHDL files from the vhdl_files/ directory
puts "Compiling VHDL modules..."
vcom -2008 ../sources/module1.vhd
puts "Compiled module1.vhd"
vcom -2008 ../sources/module2.vhd
puts "Compiled module2.vhd"
vcom -2008 ../sources/module3.vhd
puts "Compiled module3.vhd"
vcom -2008 ../sources/module4.vhd
puts "Compiled module4.vhd"
vcom -2008 ../sources/module5.vhd
puts "Compiled module5.vhd"

# Compile testbenches from the testbenches/ directory
puts "Compiling testbenches..."
vcom -2008 ../testbenches/module1_tb1.vhd
puts "Compiled module1_tb1.vhd"
vcom -2008 ../testbenches/module1_tb2.vhd
puts "Compiled module1_tb2.vhd"
vcom -2008 ../testbenches/module2_tb1.vhd
puts "Compiled module2_tb1.vhd"
vcom -2008 ../testbenches/module2_tb2.vhd
puts "Compiled module2_tb2.vhd"
vcom -2008 ../testbenches/module3_tb1.vhd
puts "Compiled module3_tb1.vhd"
vcom -2008 ../testbenches/module3_tb2.vhd
puts "Compiled module3_tb2.vhd"
vcom -2008 ../testbenches/module4_tb1.vhd
puts "Compiled module4_tb1.vhd"
vcom -2008 ../testbenches/module4_tb2.vhd
puts "Compiled module4_tb2.vhd"
vcom -2008 ../testbenches/module5_tb1.vhd
puts "Compiled module5_tb1.vhd"
vcom -2008 ../testbenches/module5_tb2.vhd
puts "Compiled module5_tb2.vhd"

# Report completion of compilation
puts "VHDL files and testbenches compiled successfully."

