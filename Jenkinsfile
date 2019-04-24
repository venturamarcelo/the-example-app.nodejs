def app_name = 'ssfdata'            // Elastic Beanstalk app name
def aws_region = 'us-west-1'        // AWS Region
def pkg_file = '/tmp/ssfdata.zip'   // Package file name
def pkg_bucket = 'ssfdata-pkg'          // S3 package bucket name
def env_dev = 'dev-env'             // Elastic Beanstalk env name for Dev
def env_qa = 'qa-env'               // Elastic Beanstalk env name for QA
def env_prod = 'prod-env'           // Elastic Beanstalk env name for Prod

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
        stage('Terraform Provisioning') {
            steps {
                sh 'terraform init'
                sh "terraform plan -var version=${env.BUILD_ID} -var app_name=${app_name} -var region=${aws_region} -var bucket=${pkg_bucket} -var dev_env=${env_dev} -var qa_env=${env_qa} -var prod_env=${env_prod}"
                sh "terraform apply -var version=${env.BUILD_ID} -var app_name=${app_name} -var region=${aws_region} -var bucket=${pkg_bucket} -var dev_env=${env_dev} -var qa_env=${env_qa} -var prod_env=${env_prod} -auto-approve"
            }
        }
        stage('Publish Artifact') {
            steps {
                sh "zip -r ${pkg_file} ."
                sh "aws s3 cp ${pkg_file} s3://${pkg_bucket}/${app_name}-v${env.BUILD_ID}.zip"
                sh "aws elasticbeanstalk create-application-version --application-name ${app_name} --version-label ${app_name}-v${env.BUILD_ID} --source-bundle S3Bucket=\"${pkg_bucket}, S3Key=${app_name}-v${env.BUILD_ID}.zip \" "                
            }
        }
        stage('Deploy Dev') {
            steps{
                sh "eb init --platform node.js --region ${aws_region} ${app_name}"
                sh "eb deploy ${env_dev} --version ssfdata-v${env.BUILD_ID}"
            }
        }
        stage('Deploy QA'){
            input {
                message 'Do you approve promotion to QA?'
                }
                
            steps {
                sh "eb deploy ${env_qa} --version ssfdata-v${env.BUILD_ID}"
            }
        }
        stage('Deploy Prod'){
            input {
                message 'Do you approve promotion to Prod?'
                }
                
            steps {
                sh "eb deploy ${env_prod} --version ssfdata-v${env.BUILD_ID}"
            }
        }
    }
}
