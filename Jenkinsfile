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
                dir('scripts') {
                    script {
                        // Add ModelSim path to system PATH
                        withEnv(["PATH+MODELSIM=${env.MODELSIM_PATH}"]) {
                            // Run compile.tcl using ModelSim's vsim
                            bat '"vsim" -c -do "do compile.tcl; exit"'
                        }
                    }
                }
            }
        }

        stage('Run Testbenches') {
            steps {
                dir('scripts') {
                    script {
                        // Add ModelSim path to system PATH
                        withEnv(["PATH+MODELSIM=${env.MODELSIM_PATH}"]) {
                            // Run testbenches using ModelSim's vsim
                            bat '"vsim" -c -do "do run_testbenches.tcl; exit"'
                        }
                    }
                }
            }
        }
        
        stage('Publish Results') {
            steps {
                // Assuming you're generating results in JUnit XML format
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
