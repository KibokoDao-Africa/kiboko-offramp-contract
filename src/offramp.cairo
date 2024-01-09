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
    use super::{ContractAddress, TokenAddress};
    use offramp::interfaces::{OfframpTransaction, OnrampTrasaction, IOfframp};
    use offramp::utils::{Token, Quantity};


    #[storage]
    struct Storage {
        owner: ContractAddress,
        contract_balance: LegacyMap<Token, Quantity>,
    }
    #[event]
    #[derive(Drop, starknet::Event)]
    enum Event {
        OfframpTransaction:OfframpTransaction,
    }

    #[external(v0)]
    impl Offramp of super::IOfframp<ContractState> {
        fn trasfer(
            ref self: ContractState,
            sender_address: ContractAdress,
            token: ContractAddress,
            no_of_token: u256,
            
        ) {
            //transfers tokens
            //updates contract_balance

            let token_: IERC20Dispatcher = IERC20Dispatcher { contract_address: token };
            let result = token_
                .trasferFrom(get_caller_address(), get_contract_address(), no_of_token);
            if result {
                let transaction = OfframpTransaction { token, no_of_token, sender_address };
                self.contract_balance.write(token, self.contract_balance.read(token) + no_of_token);
            }
        // self.balance.write(self.balance.read() + quantity);

        }

        fn get_balance(self: @ContractState) -> felt252 {
            self.balance.read()
        }

        fn withdraw(ref self: contractState, token: Token, no_of_token: Quantity) {
            assert(self.owner.read() == get_caller_address(), 'Only Owner can Call');
            let token_: IERC20Dispatcher = IERC20Dispatcher { contract_address: token };
            let result = token_.trasfer(get_caller_address(), no_of_token);
            self.contract_balance.write(token, self.contract_balance.read(token) - no_of_token);
        }

        fn offramp(ref self: phone_number, ref self: net_amount) -> T {
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


