pipeline {
    agent any

    environment {
        MODELSIM_PATH = 'C:\\intelFPGA\\18.1\\modelsim_ase\\win32aloem'
        SOURCES_PATH = 'C:\\ProgramData\\Jenkins\\.jenkins\\workspace\\Testing\\source'
        TESTBENCHES_PATH = 'C:\\ProgramData\\Jenkins\\.jenkins\\workspace\\Testing\\testbenches'
        WORK_PATH = 'C:\\ProgramData\\Jenkins\\.jenkins\\workspace\\Testing\\work'
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
                    // Remove existing work library if it exists
                    bat "if exist ${WORK_PATH} rmdir /s /q ${WORK_PATH}"
                    
                    // Create and map the work library
                    bat "${MODELSIM_PATH}\\vlib ${WORK_PATH} >> result.log 2>&1"
                    bat "${MODELSIM_PATH}\\vmap work ${WORK_PATH} >> result.log 2>&1"
                    
                    // Check if work directory is created
                    bat "dir ${WORK_PATH} >> result.log 2>&1"
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
                        echo Running testbench: %%~nf
                        ${MODELSIM_PATH}\\vsim -c -do "run -all; exit;" work.%%~nf >> testbench_result.log 2>&1
                    )
                    """
                }
            }
        }

        stage('Publish Results') {
            steps {
                junit '**/test_results/*.xml'
            }
        }
    }

    post {
        always {
            archiveArtifacts artifacts: '**/test_results/*.xml', allowEmptyArchive: true
            archiveArtifacts artifacts: 'source_result.log', allowEmptyArchive: true
            archiveArtifacts artifacts: 'testbench_result.log', allowEmptyArchive: true
        }
    }
}
