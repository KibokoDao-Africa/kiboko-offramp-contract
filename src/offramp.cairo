
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
    use offramp::utils::{Token,Quantity};


    #[storage]
    struct Storage {
        owner: ContractAddress,
        contract_balance:LegacyMap<Token,Quantity> ,
             
    }


    #[external(v0)]
    impl Offramp of super::IOfframp<ContractState> {
        fn trasfer(ref self: ContractState,
         token:ContractAddress,
         quantity: u256,
         phone_number:felt252,
         gross_amount:u256,
          net_amount:u256
         
         ) {
            //transfers tokens
            //updates contract_balance
            
          let token_ :IERC20Dispatcher= IERC20Dispatcher{contract_address:token } ;
          let result =token_.trasferFrom(get_caller_address(),get_contract_address(),quantity ) ;
          if result{
            let transaction =Transaction{
                token,
                quantity,
                phone_number,
                gross_amount,
                net_amount

            };
            self.contract_balance.write(token,self.contract_balance.read(token)+quantity);

          }
            
            // self.balance.write(self.balance.read() + quantity);

        }

        fn get_balance(self: @ContractState) -> felt252 {
            self.balance.read()
        }

fn withdraw(ref self:contractState,token:Token,quantity:Quantity ) {
    assert(self.owner.read()==get_caller_address(),'Only Owner can Call');
let token_ :IERC20Dispatcher= IERC20Dispatcher{contract_address:token } ;
let result =token_.trasfer(get_caller_address(),quantity ) ;
self.contract_balance.write(token,self.contract_balance.read(token)-quantity);

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