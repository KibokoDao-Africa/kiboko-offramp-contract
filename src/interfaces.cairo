use starknet::ContractAddress;

struct Trasaction{
    token:ContractAdress,
    quantity:u256,
    phone_number:felt252,
    gross_amount:u256,
    net_amount:u256
}



#[starknet::interface]
trait IOfframp<TContractState> {

    fn transfer(ref self: @TContractState,
    token:ContractAddress,
    quantity:u256,
    phone_number:felt252,
    gross_amount:u256,
    net_amount:u256)
    ;

    fn offramp(ref self: @TContractState,phone_number:felt252,net_amount:u256)->felt252;
    
    } 

//AOB functions
// fn get_balance(self: TContractState) -> felt252;
// fn increase_balance(ref self: TContractState, amount: felt252);
//fn decrease balance(ref self: TContractState, amount: felt252);

//fn withdraw;
//fn get_amount to_send_user

