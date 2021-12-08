scripts_path="/Users/sam/Documents/dev/CCXT/test_scripts"
source "${scripts_path}/helper_functions.sh"

exchange=$1
symbol=$2
file="${output_folder}/order_book_test.md"

function test_fetch_order_book() {
    limit=$1
    level=$2
    if [ ! -z $2 ]; then
        params="{\"level\": ${level}}"
    fi
    echo "### SYMBOL, limit=${limit} params=${params}" >> $file
    echo '```' >> $file
    node $ccxt_path $exchange fetchOrderBook $symbol $limit "$params" 2>&1 | condense_output >> $file 
    echo '```' >> $file
    echo "" >> $file
}


ccxt_diagnostics > $file

test_fetch_order_book 
test_fetch_order_book 20
test_fetch_order_book 100
test_fetch_order_book undefined 2
test_fetch_order_book undefined 3
test_fetch_order_book 20 2
test_fetch_order_book 100 2
test_fetch_order_book 20 3
test_fetch_order_book 100 3
