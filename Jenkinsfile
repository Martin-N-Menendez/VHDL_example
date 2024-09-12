pipeline {
    agent any

    environment {
        MODELSIM_PATH = 'C:\\intelFPGA\\18.1\\modelsim_ase\\win32aloem'
        SOURCES_PATH = 'C:\\ProgramData\\Jenkins\\.jenkins\\workspace\\Testing\\source'
        TESTBENCHES_PATH = 'C:\\ProgramData\\Jenkins\\.jenkins\\workspace\\Testing\\testbenches'
        WORK_PATH = 'C:\\ProgramData\\Jenkins\\.jenkins\\workspace\\Testing\\work'
    }

    stages {
        stage('Setup') {
            steps {
                script {
                    // Clear all previous logs
                    bat 'del /q result.log'
                    bat 'del /q source_result.log'
                    bat 'del /q testbench_result.log'
                    bat 'del /q run_testbench_result.log'
                }
            }
        }

        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/Martin-N-Menendez/VHDL_example.git'
            }
        }

        stage('Setup Work Library') {
            steps {
                script {
                    // Create and map the work library
                    bat "${MODELSIM_PATH}\\vlib work >> result.log 2>&1"
                    bat "${MODELSIM_PATH}\\vmap work ${WORK_PATH} >> result.log 2>&1"
                    
                    // Check if work directory is created
                    bat 'dir work >> result.log 2>&1'
                }
            }
        }

        stage('Compile VHDL Files') {
            steps {
                script {
                    // Compile all VHDL files in the sources directory
                    bat """
                    for %%f in (${SOURCES_PATH}\\*.vhd) do (
                        echo ${MODELSIM_PATH}\\vcom -2008 -work work "%%f" >> source_result.log 2>&1
                        ${MODELSIM_PATH}\\vcom -2008 -work work "%%f" >> source_result.log 2>&1
                    )
                    """
                }
            }
        }

        stage('Compile Testbenches') {
            steps {
                script {
                    // Compile all testbenches in the testbenches directory
                    bat """
                    for %%f in (${TESTBENCHES_PATH}\\*.vhd) do (
                        echo ${MODELSIM_PATH}\\vcom -2008 -work work "%%f" >> testbench_result.log 2>&1
                        ${MODELSIM_PATH}\\vcom -2008 -work work "%%f" >> testbench_result.log 2>&1
                    )
                    """
                }
            }
        }

        stage('Run Testbenches') {
            steps {
                script {
                    // Run all testbenches in the testbenches directory
                    bat """
                    for %%f in (${TESTBENCHES_PATH}\\*.vhd) do (
                        echo ${MODELSIM_PATH}\\vsim -c -do "run -all; exit;" -lib work "%%~nf" >> run_testbench_result.log 2>&1
                        ${MODELSIM_PATH}\\vsim -c -do "run -all; exit;" -lib work "%%~nf" >> run_testbench_result.log 2>&1
                    )
                    """
                }
            }
        }

        stage('Convert Results to XML') {
            steps {
                script {
                    bat "python convert_to_junit_xml.py run_testbench_result.log test_results.xml"
                }
            }
        }

        stage('Publish Results') {
            steps {
                junit '**/test_results.xml'
            }
        }
    }

    post {
        always {
            archiveArtifacts artifacts: 'source_result.log', allowEmptyArchive: true
            archiveArtifacts artifacts: 'testbench_result.log', allowEmptyArchive: true
            archiveArtifacts artifacts: 'run_testbench_result.log', allowEmptyArchive: true
            archiveArtifacts artifacts: 'results/test_results.xml', allowEmptyArchive: true
        }
    }
}
