pipeline {
    agent any
    triggers {
      pollSCM('*/1 * * * *')
    }
    stages {
        stage('install-pip-deps') {
            steps {
              echo "Installing all pip dependencies..."
              git branch : 'main', poll: false, url: 'https://github.com/mtararujs/python-greetings'
              sh "python3 -m venv .venv"
              sh ".venv/bin/python3 -m pip install -r requirements.txt"
            }
        }
        stage('deploy-to-dev') {
            steps {
                deploy("dev", 7001)
            }
        }
        stage('tests-on-dev') {
            steps {
                test("dev")
            }
        }
        stage('deploy-to-stg') {
            steps {
                deploy("stg", 7002)
            }
        }
        stage('tests-on-stg') {
            steps {
                test("stg")
            }
        }
        stage('deploy-to-preprod') {
            steps {
                deploy("preprod", 7003)
            }
        }
        stage('tests-on-preprod') {
            steps {
                test("preprod")
            }
        }
        stage('deploy-to-prod') {
            steps {
                deploy("prod", 7004)
            }
        }
        stage('tests-on-prod') {
            steps {
                test("prod")
            }
        }
    }
}

def deploy(String env, int port){
    sh '''
    export BUILD_ID=dontKillMePlease
    pm2 list
    '''
    echo "Deploying the app to ${ env } environment..."
    sh "pm2 delete \"greetings-app-${ env }\" || true"
    sh "pm2 start \".venv/bin/python3 app.py\" --name greetings-app-${ env } -- --port ${ port }"
}

def test(String env){
    sh 'pm2 list'
    echo "Testing the app on ${ env } environment..."
    git branch : 'main', poll: false, url: 'https://github.com/mtararujs/course-js-api-framework' 
    sh "npm install"
    sh "npm run greetings greetings_${ env }"
}
