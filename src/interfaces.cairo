use starknet::ContractAddress;

struct Trasaction{
    token:ContractAdress,
    quantity:u256,
    phone_number:felt252,
    gross_amount:u256
    
}



#[starknet::interface]
trait IOfframp<TContractState> {
    // fn increase_balance(ref self: TContractState, amount: felt252);
    fn get_balance(self: TContractState) -> felt252;

    fn transfer(ref self: @TContractState,quantity:u256)->felt252;
    fn offramp(ref self: @TContractState,phone_number:felt252,gross_amount:u256)->felt252;
    fn withdraw()  ;  

}