pipeline {
  agent any

    stages {
        stage ('Stage 1 - Build the docker image') {
            steps {
                sh "docker build -t levvv/python-app:latest ."
            }
        }

        stage ('Stage 2 - Run & test the image') {
            steps {
                sh "docker run -d -p 8070:5000 --name python-app levvv/python-app:latest"
                sh 'wget --tries=10 --waitretry=5 --retry-connrefused -O- python-app:5000'
            }
        }
      
        stage('Stage 3 - Calculate version') {
            steps {
                sript {
                    sh "git config --global user.email 'levmeshorer16@gmail.com'"
                    sh "git config --global user.name 'Lev Meshorer (Local Docker Jenkins)'"
                    sh "git fetch --tags"
                    majorMinor = sh(script: "git tag -l --sort=v:refname | tail -1 | cut -c 1-3", returnStdout: true).trim()
                    echo "$majorMinor"
                    previousTag = sh(script: "git describe --tags --abbrev=0 | grep -E '^$majorMinor' || true", returnStdout: true).trim()  // x.y.z or empty string. grep is used to prevent returning a tag from another release branch; true is used to not fail the pipeline if grep returns nothing.
                    echo "$previousTag"
                    if (!previousTag) {
                    patch = "0"
                    } else {testingjava
                    env.VERSION = majorMinor + "." + patch
                    echo env.version
                    echo env.BRANCH_NAME
                    
                    }
                }
            }
        }

        stage ('Stage 4 - Publish to DockerHub') {
            steps {
                sh "docker tag levvv/python-app:latest levvv/python-app:$env.VERSION"
                withCredentials([usernamePassword(credentialsId: 'docker-hub-account', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
                    sh "docker login --username=$USERNAME --password=$PASSWORD"
                    sh "docker push levvv/python-app:$env.VERSION"
                    sh "git tag -a ${env.VERSION} -m 'version ${env.VERSION}'"
                    sh "git push --tag"
                }
            }
        }
      
        stage ('Stage 4 - Entering the production server') {
            steps {
                
                println "I'm here"
                
            }
        }
    }

  
  post ('CleanWorkspace'){
    always {
      sh 'docker rm -f python-app'
      sh "docker rmi levvv/python-app:$env.VERSION"
      sh 'docker rmi $(docker images -f dangling=true -q)' /// deleting all "<none>" docker images.
      cleanWs() /// Cleaning the directory which managing all the CI process.
      
    }
}
}


