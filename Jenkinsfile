pipeline {
    agent any
    
    tools {nodejs "node"} // Requires NodeJS plugin and a node version called "node"
    // 

    stages {
        stage('Installing') {
            steps {
                sh 'node -v'
                sh 'npm install'
            }
        }
        stage('Testing') {
            steps {
                sh 'npm test'
            }
        }
        stage('Publishing') {
            steps {
                echo 'zipping artifact'
                echo 'publishing to s3 bucket'
            }
        }
        stage('Terraform') {
            steps {
                echo 'creating new Elastic Beanstalk version'
            }
        }
        stage('Deploy') {
            steps{
                echo 'eb deploy...'
            }
        }
    }
}
