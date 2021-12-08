scripts_path="/Users/sam/Documents/dev/CCXT/test_scripts"
source "${scripts_path}/helper_functions.sh"

exchange=$1
symbol=$2
file="${output_folder}/create_order_test.md"
amount="10"
amount2="5"
buy_price="1.50"
buy_trigger="1.60"
sell_trigger="2.5"
sell_price="2"

function test_order() {
    type=$1
    side=$2
    amount=$3
    price=$4
    stopPrice=$5
    expiration=$6
    reduceOnly=$7
    timeInForce=$5
    params="{\"stopPrice\": ${stopPrice}, \"expiration\": ${expiration}, \"reduceOnly\": ${reduceOnly}, \"timeInForce\": ${timeInForce},}"
    echo "### type=${type} side=${side} amount=${amount} price=${price} params=${params}" >> $file
    echo '```' >> $file
    node $ccxt_path $exchange createOrder $symbol $type $side $amount $price $params 2>&1 | condense_output >> $file
    echo '```' >> $file
    echo "" >> $file
}

ccxt_diagnostics > $file
# test_order type side amount, price, stopPrice expiration reduceOnly timeInForce
test_order limit buy  $amount $buy_price undefined undefined undefined undefined
test_order limit buy  $amount undefined undefined undefined undefined undefined
test_order limit sell $amount $sell_price undefined undefined undefined undefined
test_order limit sell $amount undefined undefined undefined undefined undefined

test_order market buy  $amount2 $buy_price undefined undefined undefined undefined
test_order market buy  $amount2 undefined undefined undefined undefined undefined
test_order market sell $amount2 $sell_price undefined undefined undefined undefined
test_order market sell $amount2 undefined undefined undefined undefined undefined

test_order limit buy  $amount $buy_price $buy_trigger undefined undefined undefined
test_order limit buy  $amount undefined $buy_trigger undefined undefined undefined
test_order limit sell $amount $sell_price $sell_trigger undefined undefined undefined
test_order limit sell $amount undefined $sell_trigger undefined undefined undefined

test_order market buy  $amount2 $buy_price $buy_trigger undefined undefined undefined
test_order market buy  $amount2 undefined $buy_trigger undefined undefined undefined
test_order market sell $amount2 $sell_price $sell_trigger undefined undefined undefined
test_order market sell $amount2 undefined $sell_trigger undefined undefined undefined

test_order limit  buy $amount  $buy_price undefined 3600 undefined undefined
test_order market buy $amount2 $buy_price undefined 3600 undefined undefined
test_order limit  buy $amount  $buy_price $buy_trigger 3600 undefined undefined
test_order market buy $amount2 $buy_price $buy_trigger 3600 undefined undefined

test_order limit  buy $amount  $buy_price undefined 3600 true undefined
test_order market buy $amount2 $buy_price undefined 3600 true undefined
test_order limit  buy $amount  $buy_price $buy_trigger 3600 true undefined
test_order market buy $amount2 $buy_price $buy_trigger 3600 true undefined

test_order limit  buy $amount  $buy_price undefined 3600 true gtc
test_order market buy $amount2 $buy_price undefined 3600 true gtc
test_order limit  buy $amount  $buy_price $buy_trigger 3600 true gtc
test_order market buy $amount2 $buy_price $buy_trigger 3600 true gtc

test_order limit  buy $amount  $buy_price undefined 3600 true ioc
test_order market buy $amount2 $buy_price undefined 3600 true ioc
test_order limit  buy $amount  $buy_price $buy_trigger 3600 true ioc
test_order market buy $amount2 $buy_price $buy_trigger 3600 true ioc