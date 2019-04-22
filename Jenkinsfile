pipeline {
    agent any
    
    tools {nodejs "node"} // Requires NodeJS plugin and a node version called "node"
    // 

    stages {
        stage('Intall Dependencies') {
            steps {
                sh 'node -v'
                sh 'npm install'
            }
        }
        stage('Test') {
            steps {
                echo 'Testing...'
                //sh 'npm test'
            }
        }
        stage('Publish Artifact') {
            steps {
                echo 'zipping artifact'
                sh 'tar -czf /tmp/ssfdata.tar.gz .'
                echo 'publishing to s3 bucket'
                sh "aws s3 cp /tmp/ssfdata.tar.gz s3://ssfdata/ssfdata-v${env.BUILD_ID}.tar.gz" //{parameter}
            }
        }
        stage('TF Versioning') {
            steps {
                echo 'creating new Elastic Beanstalk version'
                sh 'terraform init'
                sh "terraform apply -var version=${env.BUILD_ID} -auto-approve"
            }
        }
        stage('Deploy dev') {
            steps{
                echo 'eb deploy...'
                sh 'eb init --region us-west-1 ssfdata' //{parameter}
                // eb deploy <environment_name> --version <version_label>
                sh 'eb deploy dev-env --version ssfdata-v${env.BUILD_ID}'

            }
        }
    }
}
