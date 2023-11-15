//1.initialize contract.
//2.Storage struct .
//3. Add methods to a trait.
//4.Implement events.

//pesedo-code
//fetch phone number, rate
//1.fn trasfer token to contract address,emit event

//2.fn offramp(phone_number,gross_amount)->T{
    // calculate amount to send
    //let markertplace fee=0.001 *grass_amount;
    // let deduction=50
//       let total_deduction= markteplace_fee+deduction;
//             let net_amount= gross_amount-total_deduction;

//             //use chainlink adapter  to call the send money api

//             //emit event
// // }





#[starknet::contract]
mod Offramp {
    use starknet::ContractAddress;
      use core::starknet::event::EventEmitter;
    use core::traits::Into;
    use core::option::OptionTrait;
    use core::traits::TryInto;
    use core::array::ArrayTrait;
    use starknet::{get_caller_address, get_block_timestamp, get_contract_address};
    use offramp::erc20::{IERC20Dispatcher, IERC20DispatcherTrait};
    use super::{ContractAddress, CollectiveID, CycleID, HeroID, TokenAddress};
    use offramp::interfaces::{ Trasaction,IOfframp};
    
    #[storage]
    struct Storage {
        balance: felt252,
        quantity:felt252,
        // phone_number:felt252,
        // amount_inKes:felt252

    }


    #[external(v0)]
    impl Offramp of super::IOPfframp<ContractState> {
        fn trasfer(ref self: ContractState, quantity: felt252) {
            assert(quantity != 0, 'Amount cannot be 0');
            self.balance.write(self.balance.read() + quantity);

        }

        fn get_balance(self: @ContractState) -> felt252 {
            self.balance.read()
        }

        fn offramp(ref self:phone_number,ref self:gross_amount)->T{
            let mut storage = Self::get_mut();
            let balance = storage.balance.read();
            let mut markteplace_fee= 0.01 *gross_amount;
            let deduction=500;
            let total_deduction= markteplace_fee+deduction;
            let net_amount= gross_amount-total_deduction;
            //use chainlink adapter  to call the send money api
            //emit event

        }
    }
    
}
