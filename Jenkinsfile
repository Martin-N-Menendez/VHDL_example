pipeline {
    agent any

     environment {
        MODELSIM_PATH = 'C:/intelFPGA/18.1/modelsim_ase/win32aloem'
        SOURCES_PATH = 'C:/ProgramData/Jenkins/.jenkins/workspace/Testing/sources'
        TESTBENCHES_PATH = 'C:/ProgramData/Jenkins/.jenkins/workspace/Testing/testbenches'
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
                    // Print the environment path to ensure ModelSim path is correct
                    echo "ModelSim path: ${MODELSIM_PATH}"

                    bat 'rmdir /S /Q work' // Delete work directory if it exists
                    // Create and map the work library
                    bat "${MODELSIM_PATH}/vlib work"
                    bat "${MODELSIM_PATH}/vmap work work"
                    
                    // Check if work directory is created
                    bat 'dir work'
                }
            }
        }

        stage('Compile VHDL Files') {
            steps {
                script {
                    // Compile all VHDL files in the sources directory
                    bat """
                    for %%f in (${SOURCES_PATH}/*.vhd) do (
                        ${MODELSIM_PATH}/vcom -2008 %%f || exit /b
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
                    for %%f in (${TESTBENCHES_PATH}/*.vhd) do (
                        ${MODELSIM_PATH}/vcom -2008 %%f || exit /b
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
                    for %%f in (${TESTBENCHES_PATH}/*.vhd) do (
                        ${MODELSIM_PATH}/vsim -c -do "run %%~nf; exit;" || exit /b
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
        }
    }
}
