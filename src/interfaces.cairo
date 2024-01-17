use starknet::ContractAddress;

#[starknet::interface]
trait IOfframp<TContractState> {
    fn transactOfframp(
        ref self: TContractState,
        token: ContractAddress,
        no_of_token: u256,
        sender_address: ContractAddress
    );
 
}

#[starknet::interface]
trait IOnramp<TContractState> {
    fn transactOnramp(
        ref self: TContractState,
        token: ContractAddress,
        no_of_token: u256,
        receipient_address: ContractAddress,
        // recipient: ContractAddress,

    );
 
}

//AOB functions
// fn get_balance(self: TContractState) -> felt252;
// fn increase_balance(ref self: TContractState, amount: felt252);
//fn decrease balance(ref self: TContractState, amount: felt252);

//fn withdraw;
//fn get_amount to_send_user


