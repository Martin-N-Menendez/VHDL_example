import sys
import os
from xml.etree.ElementTree import Element, SubElement, tostring, ElementTree

def parse_log_to_xml(log_file, xml_file):
    # Create the root XML element
    testsuite = Element('testsuite', name='TestSuite', tests='0', failures='0', errors='0')
    
    with open(log_file, 'r') as file:
        lines = file.readlines()
        test_count = 0
        for line in lines:
            if "Test Passed" in line:
                test_count += 1
                testcase = SubElement(testsuite, 'testcase', name=f'Test{test_count}')
                # Add additional test result details here if needed
            elif "Test Failed" in line:
                testcase = SubElement(testsuite, 'testcase', name=f'Test{test_count}')
                SubElement(testcase, 'failure', message='Test failed')

    # Write XML to file
    tree = ElementTree(testsuite)
    tree.write(xml_file, encoding='utf-8', xml_declaration=True)

if __name__ == "__main__":
    if len(sys.argv) != 3:
        print("Usage: python convert_to_junit_xml.py <log_file> <xml_file>")
        sys.exit(1)

    log_file = sys.argv[1]
    xml_file = sys.argv[2]
    parse_log_to_xml(log_file, xml_file)
