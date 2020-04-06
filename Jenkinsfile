pipeline {
    agent { label 'lambda' }
    stages {
        stage('Echo'){
            steps{
                sh 'node -v'
                sh 'aws --version'
            }
        }
    }
    post {
        always {
            cleanWs()
        }
        success {
            echo 'I succeeded!'
        }
        unstable {
            echo 'I am unstable :/'
        }
        failure {
            echo 'I failed :('
        }
        changed {
            echo 'Things were different before...'
        }
    }
}