pipeline {
    agent any
    stages {
        stage('Build') {
            steps {
                sh 'echo "Starting.."'
                sh '''
                    if [ -e props.txt ]
                    then
                        rm props.txt
                    fi
                    if [ -e dir_list.txt ]
                    then
                        rm dir_list.txt
                    fi
                    for i in $(git diff --name-only HEAD HEAD~1); 
                    do
                        echo "`dirname $(dirname ${i})`" >> dir_list.txt
                    done
                    cat dir_list.txt
                    for j in $(cat dir_list.txt | sort | uniq); 
                    do
                        echo "FOLDER_PATH=$(pwd)/${j}" >> props.txt
                        echo "CHOICE=coverage_determinations" >> props.txt
                        echo "FHIR_SERVER_URL=https://fhir-dev.mettles.com/interop/fhir/" >> props.txt
                        java -jar ../Measure_creator/target/converter-1.0.0.jar  props.txt
                        rm props.txt
                    done
                    rm dir_list.txt
                
                '''
                sh 'echo "..Done.."'
            }
        }
    }
}
