use starknet::ContractAddress;

struct OfframpTrasaction {
    token: ContractAddress,
    no_of_token: u256,
    sender_address: ContractAdress
}

struct OnrampTransaction {
    token: ContractAddress,
    no_of_token: u256,
    receipient_address: ContractAdress
}


#[starknet::interface]
trait IOfframp<TContractState> {
    fn transfer(
        ref self: @TContractState,
        token: ContractAddress,
        no_of_token: u256,
        sender_address: ContractAdress
    );

    fn offramp(ref self: @TContractState, phone_number: felt252, net_amount: u256) -> felt252;
}
//AOB functions
// fn get_balance(self: TContractState) -> felt252;
// fn increase_balance(ref self: TContractState, amount: felt252);
//fn decrease balance(ref self: TContractState, amount: felt252);

//fn withdraw;
//fn get_amount to_send_user


