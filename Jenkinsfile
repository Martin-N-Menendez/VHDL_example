pipeline {
    agent any

    environment {
        MODELSIM_PATH = 'C:\\intelFPGA\\18.1\\modelsim_ase\\win32aloem'
        SOURCES_PATH = 'C:\\ProgramData\\Jenkins\\.jenkins\\workspace\\Testing\\source'
        TESTBENCHES_PATH = 'C:\\ProgramData\\Jenkins\\.jenkins\\workspace\\Testing\\testbenches'
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/Martin-N-Menendez/VHDL_example.git'
            }
        }

        stage('Setup Work Library') {
            steps {
                script {
                    // Erase old logs
                    bat 'del /q result.log'
                    bat 'del /q source_result.log'
                    bat 'del /q testbench_result.log'
                    bat 'del /q testbench_run_result.log'

                    // Create and map the work library
                    bat "${MODELSIM_PATH}\\vlib work >> result.log 2>&1"
                    bat "${MODELSIM_PATH}\\vmap work work >> result.log 2>&1"
                    
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
                        ${MODELSIM_PATH}\\vsim -c -do "run %%~nf; exit;" >> testbench_run_result.log 2>&1
                    )
                    """
                }
            }
        }

        stage('Publish Results') {
            steps {
                script {
                    // Collect and archive the test results
                    echo 'Collecting test results...'
                    // Assuming your testbenches generate XML files in the same directory
                    def testResults = findFiles(glob: '**/test_results/*.xml')
                    if (testResults.length > 0) {
                        archiveArtifacts artifacts: '**/test_results/*.xml', allowEmptyArchive: true
                        junit '**/test_results/*.xml'
                    } else {
                        echo 'No test result files found.'
                    }
                }
            }
        }
    }

    post {
        always {
            archiveArtifacts artifacts: 'source_result.log', allowEmptyArchive: true
            archiveArtifacts artifacts: 'testbench_result.log', allowEmptyArchive: true
            archiveArtifacts artifacts: 'testbench_run_result.log', allowEmptyArchive: true
        }
    }
}
