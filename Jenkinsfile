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
                echo 'Testing...'
                //sh 'npm test'
            }
        }
        stage('Publishing') {
            steps {
                echo 'zipping artifact'
                sh 'tar -czf /tmp/ssfdata.tar.gz .'
                echo 'publishing to s3 bucket'
                sh "aws s3 cp /tmp/ssfdata.tar.gz s3://ssfdata/ssfdata-v${env.BUILD_ID}.tar.gz"
            }
        }
        stage('Terraform') {
            steps {
                echo 'creating new Elastic Beanstalk version'
                sh 'terraform init'
                sh "terraform apply -var version=${env.BUILD_ID} -auto-approve"
            }
        }
        stage('Deploy') {
            steps{
                echo 'eb deploy...'
            }
        }
    }
}
