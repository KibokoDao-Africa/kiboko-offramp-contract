use starknet::ContractAddress;

#[derive(Drop, starknet::Event)]
struct OfframpTrasaction {
    token: ContractAddress,
    no_of_token: u256,
    sender_address: ContractAdress
}

#[derive(Drop, starknet::Event)]
struct OnrampTransaction {
    token: ContractAddress,
    no_of_token: u256,
    receipient_address: ContractAdress
}


#[starknet::interface]
trait IOfframp<TContractState> {
    fn transactOfframp(
        ref self: @TContractState,
        token: ContractAddress,
        no_of_token: u256,
        sender_address: ContractAdress
    );
 
}

#[starknet::interface]
trait IOnramp<TContractState> {
    fn transactOnramp(
        ref self: @TContractState,
        token: ContractAddress,
        no_of_token: u256,
        receipient_address: ContractAdress,
        // recipient: ContractAddress,

    );
 
}

//AOB functions
// fn get_balance(self: TContractState) -> felt252;
// fn increase_balance(ref self: TContractState, amount: felt252);
//fn decrease balance(ref self: TContractState, amount: felt252);

//fn withdraw;
//fn get_amount to_send_user


