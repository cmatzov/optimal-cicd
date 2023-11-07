#!/bin/bash

PROJECT=$1
SERVER="optimal@192.168.66.11"
FILE="/tmp/runner/${CI_COMMIT_BRANCH}-${PROJECT}.txt"

file_check () {
    ssh $SERVER "bash -s" << EOF
    #!/bin/bash
    cat $FILE 2>/dev/null || echo ""
EOF
}

file_check