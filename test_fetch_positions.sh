scripts_path="/Users/sam/Documents/dev/CCXT/test_scripts"
source "${scripts_path}/helper_functions.sh"
exchange=$1
file="${output_folder}/fetch_positions_test.md"

function test_fetch_positions() {
    settle=$1
    type=$2
    if [ ! -z $type ] && [ ! -z $settle ]; then
        params="{\"type\": \"${type}\", \"settle\": \"${settle}\"}"
    elif [ ! -z $type ]; then
        params="{\"type\": \"${type}\"}"
    elif [ ! -z $settle ]; then
        params="{\"settle\": \"${settle}\"}"
    fi
    echo "### settle=${settle}, type=${type}" >> $file
    echo '```' >> $file
    node $ccxt_path $exchange fetchPositions undefined "$params" 2>&1 | condense_output  >> $file
    echo "" >> $file
    echo '```' >> $file
    echo "" >> $file
    echo "------------------------------------------------------------------------------------" >> $file
    echo "" >> $file
}
    
ccxt_diagnostics > $file

test_fetch_positions
test_fetch_positions usdt
test_fetch_positions btc
test_fetch_positions '' swap
test_fetch_positions '' futures
test_fetch_positions usdt swap
test_fetch_positions usdt futures
test_fetch_positions btc swap
test_fetch_positions btc futures
