pipeline {
  agent any

  environment {
    DOCKER_IMAGE   = 'ssborde26/springboot-html'
    DOCKER_CRED_ID = 'dockerhub-creds'
  }

  stages {
    stage('Checkout') {
      steps {
        git(
          url: 'https://github.com/sachin-borde/SpringBootJpaHTML.git',
          branch: 'master',
          credentialsId: 'github-creds'
        )
      }
    }

    stage('Build JAR') {
      steps {
        // Option A: use the Maven Wrapper (ensure wrapper files are present)
        sh 'chmod +x mvnw'
        sh './mvnw clean package -DskipTests'

        // Option B: system Maven instead:
        // sh 'mvn clean package -DskipTests'
      }
    }

    stage('Build & Push Docker') {
      steps {
        script {
          // Build image tagged by build number
          def img = docker.build("${DOCKER_IMAGE}:${env.BUILD_NUMBER}")
          // Push both versioned and latest tags
          docker.withRegistry('', "${DOCKER_CRED_ID}") {
            img.push("${env.BUILD_NUMBER}")
            img.push('latest')
          }
        }
      }
    }
  }

  post {
    always {
      // Allow Groovy to expand FULL_IMAGE by using double quotes
      sh "docker rmi ${DOCKER_IMAGE}:${env.BUILD_NUMBER} || true"
      cleanWs()
    }
  }
}
