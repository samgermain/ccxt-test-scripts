scripts_path="/Users/sam/Documents/dev/CCXT/test_scripts"
source "${scripts_path}/helper_functions.sh"

exchange=$1
symbol=$2
file="${output_folder}/create_order_test.md"
amount="1"
amount2="1"
buy_price="1.50"
buy_trigger="1.60"
sell_trigger="4800"
sell_price="4700"

function test_order() {
    type=$1
    side=$2
    amount=$3
    price=$4
    if [ ! -z $5 ]; then
        stopPrice="\"stopPrice\": \"${5}\", \"stopPriceType\": \"TP\", "
    fi
    if [ ! -z $6 ]; then
        expiration="\"expiration\": \"${6}\", "
    fi
    if [ ! -z $7 ]; then
        reduceOnly="\"reduceOnly\": \"${7}\", "
    fi
    if [ ! -z $8 ]; then
        timeInForce="\"timeInForce\": \"${8}\", "
    fi
    if [ ! -z $9 ]; then
        leverage="\"leverage\": \"$9\""
    fi
    params="{${stopPrice}${expiration}${reduceOnly}${timeInForce}${leverage}}"
    echo "### type=${type} side=${side} amount=${amount} price=${price} params=${params}" >> $file
    echo '```' >> $file
    node $ccxt_path $exchange createOrder $symbol $type $side $amount $price "$params" 2>&1 | condense_output >> $file
    echo '```' >> $file
    echo "" >> $file
}

ccxt_diagnostics > $file
# # test_order type side amount, price, stopPrice expiration reduceOnly timeInForce
# test_order limit buy  $amount $buy_price '' '' '' '' 10
# test_order limit buy  $amount undefined '' '' '' '' 10
# test_order limit sell $amount $sell_price '' '' '' '' 10
# test_order limit sell $amount undefined '' '' '' '' 10

# test_order market buy  $amount2 $buy_price '' '' '' '' 10
# test_order market buy  $amount2 undefined '' '' '' '' 10
# test_order market sell $amount2 $sell_price '' '' '' '' 10
# test_order market sell $amount2 undefined '' '' '' '' 10

test_order limit buy  $amount $buy_price $buy_trigger '' '' '' 10
test_order limit buy  $amount undefined $buy_trigger '' '' '' 10
test_order limit sell $amount $sell_price $sell_trigger '' '' '' 10
test_order limit sell $amount undefined $sell_trigger '' '' '' 10

test_order market buy  $amount2 $buy_price $buy_trigger '' '' '' 10
test_order market buy  $amount2 undefined $buy_trigger '' '' '' 10
test_order market sell $amount2 $sell_price $sell_trigger '' '' '' 10
test_order market sell $amount2 undefined $sell_trigger '' '' '' 10

# test_order limit  buy $amount  $buy_price '' 3600 '' '' 10
# test_order market buy $amount2 $buy_price '' 3600 '' '' 10
# test_order limit  buy $amount  $buy_price $buy_trigger 3600 '' '' 10
# test_order market buy $amount2 $buy_price $buy_trigger 3600 '' '' 10

# test_order limit  buy $amount  $buy_price '' 3600 true '' 10
# test_order market buy $amount2 $buy_price '' 3600 true '' 10
# test_order limit  buy $amount  $buy_price $buy_trigger 3600 true '' 10
# test_order market buy $amount2 $buy_price $buy_trigger 3600 true '' 10

# test_order limit  buy $amount  $buy_price '' 3600 true gtc 10
# test_order market buy $amount2 $buy_price '' 3600 true gtc 10
# test_order limit  buy $amount  $buy_price $buy_trigger 3600 true gtc 10
# test_order market buy $amount2 $buy_price $buy_trigger 3600 true gtc 10

# test_order limit  buy $amount  $buy_price '' 3600 true ioc 10
# test_order market buy $amount2 $buy_price '' 3600 true ioc 10
# test_order limit  buy $amount  $buy_price $buy_trigger 3600 true ioc 10
# test_order market buy $amount2 $buy_price $buy_trigger 3600 true ioc 10