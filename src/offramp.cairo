//1.initialize contract.
//2.Storage struct .
//3. Add methods to a trait.
//4.Implement events.

//pesedo-code
//fetch phone number, rate
//1.fn trasfer token to contract address,emit event

//2.fn offramp(phone_number,gross_amount)->T{

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
    use super::{ContractAddress,TokenAddress};
    use offramp::interfaces::{ Trasaction,IOfframp};
    use cycle_stark::utils::{Token,Quantity};


    #[storage]
    struct Storage {
        owner: ContractAddress,
        contract_balance:LegacyMap<Token,Quantity>       
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

        fn offramp(ref self:phone_number,ref self:net_amount)->T{
            let mut storage = Self::get_mut();
            let balance = storage.balance.read();
           
            //use chainlink adapter  to call the send money api
            //emit event

        }
    }
    
}
// shall do this from frontend insteas so as to get net_amount
// gross_amount=no_of tokens *rate;
 //let mut markteplace_fee= 0.01 *gross_amount;
        //    let deduction=500;
         //   let total_deduction= markteplace_fee+deduction;
          //  let net_amount= gross_amount-total_deduction;