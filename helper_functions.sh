scripts_path="/Users/sam/Documents/dev/CCXT/test_scripts"
ccxt_js='/Users/sam/Documents/dev/CCXT/ccxt/ccxt.js'
ccxt_path='/Users/sam/Documents/dev/CCXT/ccxt/examples/js/cli.js'
output_folder="${scripts_path}/test_output"

function condense_output() {
    cat $1 | sed -e 's/\[[0-9]\{1,2\}m//g' | sed -e 's/^20[0-9][0-9].*$//g' | sed -e 's/^Node.*$//g' | sed -e 's/^CCXT.*$//g' | awk 'NF' | awk -v head=5 -v tail=3 'FNR<=head
    {lines[FNR]=$0}
    END{
        print "..."
        for (i=FNR-tail+1; i<=FNR; i++) print lines[i]
    }'
}

function test_symbol_since_limit() {
    symbol=$1
    since=$2
    limit=$3
    if [ ! -z $since ] && [ $since != undefined ]; then
        seconds=$(echo " $since / 1000 " | bc -l | sed -e 's/\..*//g' )
        d=$( date -u -r $seconds )
    fi
    echo "### symbol=${symbol} since=${since} limit=${limit} date=${d} " >> $file
    echo '```' >> $file
    node $ccxt_path $exchange $method $symbol $since $limit 2>&1 | condense_output  >> $file
    echo '```' >> $file
    echo "" >> $file
    d=""
    symbol=""
    since=""
    limit=""
}

function test_symbol_since_limit_tests() {
    
    method=$1
    exchange=$2
    # symbol=$3
    file="${output_folder}/${method}.md"
    ccxt_diagnostics > $file

    test_symbol_since_limit
    test_symbol_since_limit $3
    test_symbol_since_limit $3 1635724800000
    test_symbol_since_limit $3 undefined 5
    test_symbol_since_limit $3 1635724800000 5
}

function ccxt_diagnostics() {
    version=$(node <<< "const ccxt        = require (\"${ccxt_js}\"); console.log ('CCXT v' + ccxt.version)")
    date -u '+%y/%m/%d %H:%M:%S %z'
    echo "Node.js: $(node -v)"
    echo $version
    echo ""
}
