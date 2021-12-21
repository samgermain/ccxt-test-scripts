scripts_path="/Users/sam/Documents/dev/CCXT/test_scripts"
source "${scripts_path}/helper_functions.sh"

function test_transfer() {
    code=$1
    fromAccount=$2
    toAccount=$3
    amount='1'

    echo "### code=${code} fromAccount=${fromAccount} toAccount=${toAccount}" >> $file
    echo '```' >> $file
    node $ccxt_path $exchange transfer $code $amount $fromAccount $toAccount 2>&1 | condense_output >> $file
    echo '```' >> $file
    echo "" >> $file
}

exchange=$1
code=$2
file="${output_folder}/test_transfer.md"
ccxt_diagnostics > $file

test_transfer $code spot trade
test_transfer $code spot trading
test_transfer $code spot future
test_transfer $code spot contract

test_transfer $code trade spot
test_transfer $code trade trading
test_transfer $code trade future
test_transfer $code trade contract

test_transfer $code trading spot
test_transfer $code trading trade
test_transfer $code trading future
test_transfer $code trading contract

test_transfer $code future spot
test_transfer $code future trade
test_transfer $code future trading
test_transfer $code future contract

test_transfer $code contract spot
test_transfer $code contract trade
test_transfer $code contract trading
test_transfer $code contract future

