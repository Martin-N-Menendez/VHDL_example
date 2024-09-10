pipeline {
    agent any
    
    stages {
        stage('Checkout') {
            steps {
                // Assuming you're using Git
                git branch: 'main', url: 'https://github.com/Martin-N-Menendez/VHDL_example.git'
            }
        }
        
        stage('Compile VHDL Files') {
            steps {
                script {
                    // Assuming you have a TCL script for compilation
                    sh 'vsim -c -do "do compile.tcl; exit"'
                }
            }
        }

        stage('Run Testbenches') {
            steps {
                script {
                    // Running testbenches using TCL script
                    sh 'vsim -c -do "do run_testbenches.tcl; exit"'
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
