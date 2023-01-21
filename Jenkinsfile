pipeline {
    agent {
        label 'ridley'
    }

    stages {
        stage("Cleaning workspace") {
            steps {
                cleanWs()
                checkout scm
                echo 'Building $JOB_NAME...'
            }
        }
        stage("Cloning git") {
            steps {
                dir('$JOB_NAME') {
                    git branch: "main", url: '$PROJECT_GIT'
                }
                git branch: "main", url: 'https://github.com/Davi-Coelho/node-docker-conf.git'
                sh 'mv Dockerfile $JOB_NAME/Dockerfile'
                sh "sed -i 's/docker_user/${DOCKER_USER}/' docker-compose.yml"
                sh "sed -i 's/PROJECT_NAME\\|project_name/${JOB_NAME}/' docker-compose.yml"
                sh "sed -i 's/PROJECT_PORT/${PROJECT_PORT}/' docker-compose.yml"
                sh "sed -i 's/DB_USER/${DB_USER}/' docker-compose.yml"
                sh "sed -i 's/DB_PASS/${DB_PASS}/' docker-compose.yml"
                sh "sed -i 's/DOMAIN/${DOMAIN}/' docker-compose.yml"
            }
        }

        stage("Copying .env file") {
            steps {
                withCredentials([file(credentialsId: "bot-env-file", variable: "envFile")]) {
                    sh 'cp $envFile $WORKSPACE'
                }
            }
        }

        stage("Stopping containers") {
            steps {
                sh "docker compose down"
            }
        }

        stage("Cleaning old images") {
            steps {
                script {
                    try {
                        sh 'docker rmi $DOCKER_USER/$JOB_NAME:latest'
                    } catch(Exception e) {
                        print("Error: " + e)
                    }
                }
                echo currentBuild.result
            }
        }
        stage("Running containers") {
            steps {
                sh "docker compose up -d --build"
            }
        }
    }
}
