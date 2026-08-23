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
        stage('Debug Deploy') {
            steps {
                sh '''
                    echo "WORKSPACE: $WORKSPACE"
        
                    ls -ld "$WORKSPACE/nginx"
                    ls -ld "$WORKSPACE/nginx/default.conf"
        
                    test -f "$WORKSPACE/nginx/default.conf" && echo "default.conf is a FILE"
                    test -d "$WORKSPACE/nginx/default.conf" && echo "default.conf is a DIRECTORY"
        
                    docker compose config
                '''
            }
        }
        stage('Deploy') {
            steps {
                sh '''
                    docker compose up -d --build
                '''
            }
        }
    }
    post {
        always {
            junit allowEmptyResults: true,
                  testResults: 'target/surefire-reports/*.xml'
        }
        success {
            archiveArtifacts artifacts: 'target/*.jar', fingerprint: true
        }
    }
}
