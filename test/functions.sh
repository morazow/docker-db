#! /bin/bash

# wait for the database to start and accept connections
# $1 = exadt folder
# $2 = database name
# $3 = cluster name
PIPENV=$(which pipenv)
wait_db() {
    cd "$1"
    # 'exec' command has been introduced with 6.0.1, so we have to check for support first!
    if [[ -z $("$PIPENV" run ./exadt --help | grep exec) ]]; then
        echo "'exec' is not supported! Sleeping for 30 seconds instead"
        sleep 30
    else
        echo "waiting for $2 to start"
        while [[ -z $("$PIPENV" run ./exadt exec -c "dwad_client shortlist" "$3" | grep "$2") ]]
        do
            sleep 3
        done
        "$PIPENV" run ./exadt exec -c "dwad_client wait-state $2 running 60" "$3"
        while true
        do
            "$PIPENV" run ./exadt exec -c "dwad_client print-params $2" "$3" 2>&1 | grep -q 'Connection state: up' && break
            sleep 3
        done
    fi
    return 0
}
 
