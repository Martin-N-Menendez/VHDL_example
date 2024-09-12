pipeline {
    agent any
    
    environment {
        MODELSIM_PATH = 'C:\\intelFPGA\\18.1\\modelsim_ase\\win32aloem'
    }

    stages {
        stage('Checkout') {
            steps {
                // Assuming you're using Git
                git branch: 'main', url: 'https://github.com/Martin-N-Menendez/VHDL_example.git'
            }
        }
        
        stage('Compile VHDL Files') {
            steps {
                dir('sources') {
                    script {
                        // Create the work library
                        bat "${MODELSIM_PATH}\\vlib work"
                        bat "${MODELSIM_PATH}\\vmap work work"

                        // Compile all VHDL files in the sources directory
                        bat """
                        for %f in (*.vhd) do (
                            ${MODELSIM_PATH}\\vcom -2008 %f
                        )
                        """
                    }
                }
            }
        }

        stage('Compile Testbenches') {
            steps {
                dir('testbenches') {
                    script {
                        // Compile all testbenches in the testbenches directory
                        bat """
                        for %f in (*.vhd) do (
                            ${MODELSIM_PATH}\\vcom -2008 %f
                        )
                        """
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
                        for %f in (*.vhd) do (
                            ${MODELSIM_PATH}\\vsim -c -do "run %~nf; exit;"
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
