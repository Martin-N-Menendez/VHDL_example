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

        stage('Compile VHDL Files') {
            steps {
                dir('source') {
                    script {
                        // Compile all VHDL files in the sources directory and log the output
                        bat """
                        for %%f in (*.vhd) do (
                            ${MODELSIM_PATH}\\vcom -2008 %%f >> compile1_log.txt 2>&1 || exit /b
                        )
                        """
                        bat 'type compile1_log.txt' // Display the content of the log file in the Jenkins console
                    }
                }
            }
        }
        
        stage('Compile Testbenches') {
            steps {
                dir('testbenches') {
                    script {
                        // Compile all testbenches in the testbenches directory and log the output
                        bat """
                        for %%f in (*.vhd) do (
                            ${MODELSIM_PATH}\\vcom -2008 %%f >> compile2_log.txt 2>&1 || exit /b
                        )
                        """
                        bat 'type compile2_log.txt' // Display the content of the log file in the Jenkins console
                    }
                }
            }
        }

        stage('Run Testbenches') {
            steps {
                dir('testbenches') {
                    script {
                        // Run all testbenches in the testbenches directory
                        bat """
                        for %%f in (*.vhd) do (
                            ${MODELSIM_PATH}\\vsim -c -do "run %%~nf; exit;" || exit /b
                        )
                        """
                    }
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
