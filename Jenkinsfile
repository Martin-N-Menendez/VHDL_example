pipeline {
    agent any

    environment {
        MODELSIM_PATH = 'C:\\intelFPGA\\18.1\\modelsim_ase\\win32aloem'
        SOURCES_PATH = 'C:\\ProgramData\\Jenkins\\.jenkins\\workspace\\Testing\\sources'
        TESTBENCHES_PATH = 'C:\\ProgramData\\Jenkins\\.jenkins\\workspace\\Testing\\testbenches'
    }

    stages {
        stage('Checkout') {
            steps {
                echo "Checking out code from Git repository..."
                git branch: 'main', url: 'https://github.com/Martin-N-Menendez/VHDL_example.git'
            }
        }

        stage('Setup Work Library') {
            steps {
                script {
                    echo "ModelSim path: ${MODELSIM_PATH}"

                    echo "Creating work library..."
                    bat "echo ${MODELSIM_PATH}\\vlib work && ${MODELSIM_PATH}\\vlib work"

                    echo "Mapping work library..."
                    bat "echo ${MODELSIM_PATH}\\vmap work work && ${MODELSIM_PATH}\\vmap work work"
                    
                    echo "Checking work directory..."
                    bat "dir work"
                }
            }
        }

        stage('Compile VHDL Files') {
            steps {
                script {
                    echo "Compiling VHDL files in sources directory..."
                    bat """
                    echo Compiling VHDL files...
                    for %%f in (${SOURCES_PATH}\\*.vhd) do (
                        echo ${MODELSIM_PATH}\\vcom -2008 -work work %%f
                        ${MODELSIM_PATH}\\vcom -2008 -work work "%%f" || exit /b
                    )
                    """
                }
            }
        }

        stage('Compile Testbenches') {
            steps {
                script {
                    echo "Compiling testbenches in testbenches directory..."
                    bat """
                    echo Compiling testbenches...
                    for %%f in (${TESTBENCHES_PATH}\\*.vhd) do (
                        echo ${MODELSIM_PATH}\\vcom -2008 -work work "%%f"
                        ${MODELSIM_PATH}\\vcom -2008 -work work "%%f" || exit /b
                    )
                    """
                }
            }
        }

        stage('Run Testbenches') {
            steps {
                script {
                    echo "Running testbenches in testbenches directory..."
                    bat """
                    echo Running testbenches...
                    for %%f in (${TESTBENCHES_PATH}\\*.vhd) do (
                        echo ${MODELSIM_PATH}\\vsim -c -do "run %%~nf; exit;"
                        ${MODELSIM_PATH}\\vsim -c -do "run %%~nf; exit;" || exit /b
                    )
                    """
                }
            }
        }

        stage('Publish Results') {
            steps {
                echo "Publishing test results..."
                junit '**/test_results/*.xml'
            }
        }
    }

    post {
        always {
            echo "Archiving test results..."
            archiveArtifacts artifacts: '**/test_results/*.xml', allowEmptyArchive: true
        }
    }
}
