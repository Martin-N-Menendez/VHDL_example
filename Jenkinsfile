pipeline {
    agent any

    environment {
        MODELSIM_PATH = 'C:\\intelFPGA\\18.1\\modelsim_ase\\win32aloem'
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

                    // Create and map the work library
                    bat "${MODELSIM_PATH}\\vlib work"
                    bat "${MODELSIM_PATH}\\vmap work work"
                    
                    // Check if work directory is created
                    bat 'dir work'
                }
            }
        }

        stage('Compile Sources') {
            steps {
                script {
                    // Compile all source files without changing directories
                    bat """
                    for %%f in (sources/*.vhd) do (
                        ${MODELSIM_PATH}\\vcom -2008 %%f || exit /b
                    )
                    """
                }
            }
        }

        stage('Compile Testbenches') {
            steps {
                script {
                    // Compile all testbenches without changing directories
                    bat """
                    for %%f in (testbenches/*.vhd) do (
                        ${MODELSIM_PATH}\\vcom -2008 %%f || exit /b
                    )
                    """
                }
            }
        }

        stage('Run Testbenches') {
            steps {
                script {
                    // Run all testbenches without changing directories
                    bat """
                    for %%f in (testbenches/*.vhd) do (
                        ${MODELSIM_PATH}\\vsim -c -do "run -all; exit;" || exit /b
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
