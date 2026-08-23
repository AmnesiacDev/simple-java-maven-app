pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                git url: 'https://github.com/AmnesiacDev/simple-java-maven-app', branch: 'master'
            }
        }
        stage('Build') {
            steps {
                sh 'mvn clean compile'
            }
        }
        stage('Test') {
            steps {
                sh 'mvn test'
            }
        }
        stage('Package') {
            steps {
                sh 'mvn package'
            }
        }
        stage('Build Docker Image') {
            steps {
                script {
                    def imageName = "java-maven-app:${env.BUILD_NUMBER}"
                    sh "docker build -t ${imageName} ."
                }
            }
        }
        stage('Deploy') {
            steps {
                sh '''
                    docker rm -f java-maven-app || true
                    docker run --name java-maven-app java-maven-app:${BUILD_NUMBER}
                '''
            }
        }
    }
    post {
        always {
            junit 'target/surefire-reports/*.xml'
        }
        success {
            archiveArtifacts artifacts: 'target/*.jar', fingerprint: true
        }
    }
}
