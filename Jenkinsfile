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
              sh 'ls'
              sh "python3 -m venv .venv"
              sh ".venv/bin/pip3 install -r requirements.txt"
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
def build() {
    echo 'Building of node application is starting..'
    sh "npm install"
    sh "npm test"
}

def deploy(String env, int port){
    echo "Deploying the app to ${ env } environment..."
    sh "source .venv/bin/activate \n"
    sh "pm2 delete \"greetings-app-${ env }\" || true"
    sh "pm2 start .venv/bin/app.py --name greetings-app-${ env } -- --port ${ port }"
}

def test(String env){
    echo "Testing the app on ${ env } environment..."
    git branch : 'main', poll: false, url: 'https://github.com/mtararujs/course-js-api-framework' 
    sh "npm install"
    sh "npm run greetings greetings_${ env }"
}
