# SPDX-License-Identifier: Apache-2.0

//Import the Cairo prelude.
import starknet.cairo.prelude;

// Define a struct to store price feed information.
struct PriceFeed {
    address addr;
    uint256 decimals;
}

// Define a mapping to store currency symbol => price feed information.
price_feeds: starknet.storage.LegacyMap[string, PriceFeed]

//Define a function to get the latest price of a given quantity of a token in a specific currency.
fn get_price(quantity: felt, token_address: felt, currency: felt) -> felt {
    //Get the price feed information for the specified currency.
    let price_feed = price_feeds.read(currency);

    // Get the latest price data from the price feed.
    let (price, _, _, _, _) = starknet.chain.call(price_feed.addr, "latestRoundData", []);

    // Calculate the price in USD.
    let price_in_usd = price * quantity / (10**price_feed.decimals);

    //Convert the price to the required currency.
    let converted_price = convert_currency(price_in_usd, "USD", currency);

    return converted_price;
}

//Define a function to convert an amount from one currency to another.
fn convert_currency(amount: felt, from_currency: felt, to_currency: felt) -> felt {
    //Get the price feed information for the fromCurrency.
    let from_price_feed = price_feeds.read(from_currency);

    //Get the price feed information for the toCurrency.
    let to_price_feed = price_feeds.read(to_currency);

    // Get the latest price of the fromCurrency.
    let (_, from_price, _, _, _) = starknet.chain.call(from_price_feed.addr, "latestRoundData", []);

    //Get the latest price of the toCurrency.
    let (_, to_price, _, _, _) = starknet.chain.call(to_price_feed.addr, "latestRoundData", []);

    //Calculate the conversion rate.
    let conversion_rate = (from_price * (10**18)) / to_price;

    //Convert the amount using the conversion rate.
    let converted_amount = (amount * conversion_rate) / (10**18);

    //Return the converted amount.
    return converted_amount;
}

// Define a function to set the price feed for a given currency.
fn set_price_feed(currency: felt, price_feed_address: felt) {
    // Set the price feed information for the given currency.
    price_feeds.write(currency, PriceFeed {
        addr: price_feed_address,
        decimals: 18,
    });
}