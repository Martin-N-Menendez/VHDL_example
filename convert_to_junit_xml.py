import xml.etree.ElementTree as ET

def parse_log(log_file):
    test_cases = []
    with open(log_file, 'r') as file:
        lines = file.readlines()
        for i, line in enumerate(lines):
            # Look for the start of a testbench simulation
            if 'vsim -c -do' in line and '-lib work' in line:
                test_case_name = line.split()[-1].strip('"')
                errors = 0
                warnings = 0
                # Scan for errors and warnings within this testbench block
                for j in range(i, len(lines)):
                    if 'Errors' in lines[j]:
                        errors = int(lines[j].split()[-2])  # Extract the number of errors
                    if 'Warnings' in lines[j]:
                        warnings = int(lines[j].split()[-2])  # Extract the number of warnings
                    if 'exit' in lines[j]:  # End of this test case block
                        break
                test_cases.append((test_case_name, errors, warnings))
    return test_cases

def generate_junit_xml(test_cases, output_file):
    testsuite = ET.Element('testsuite', name='TestSuite', tests=str(len(test_cases)))
    for name, errors, warnings in test_cases:
        # Split the testbench name and convert to MODULE.TEST format
        if "_" in name:
            module_name, testbench_name = name.split("_", 1)
            classname = f"{module_name}.{testbench_name}"
        else:
            classname = name  # If the name doesn't match the format, leave it unchanged
        testcase = ET.SubElement(testsuite, 'testcase', classname=classname, name=name)
        if errors > 0:
            ET.SubElement(testcase, 'error', message=f'{errors} errors', type="Error")
        if warnings > 0:
            ET.SubElement(testcase, 'failure', message=f'{warnings} warnings', type="Warning")
    tree = ET.ElementTree(testsuite)
    tree.write(output_file, encoding='utf-8', xml_declaration=True)
    
if __name__ == '__main__':
    log_file = 'run_testbench_result.log'
    output_file = 'test_results.xml'
    test_cases = parse_log(log_file)
    generate_junit_xml(test_cases, output_file)
