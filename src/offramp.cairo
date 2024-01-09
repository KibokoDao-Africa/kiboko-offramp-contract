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
        OfframpTransaction: OfframpTransaction,
    }

    #[event]
    #[derive(Drop, starknet::Event)]
    enum Event {
        OnrampTransaction: OnrampTransaction,
    }


    #[external(v0)]
    impl Offramp of super::IOfframp<ContractState> {
        fn transactOfframp(
            ref self: ContractState,
            sender_address: ContractAdress,
            token: ContractAddress,
            no_of_token: u256,
        ) {
            //transfers tokens
            //updates contract_balance

            let token_: IERC20Dispatcher = IERC20Dispatcher { contract_address: token };
            let result = token_
            .transferFrom(sender_address,get_contract_address,no_of_token);
                // .transferFrom(get_caller_address(), get_contract_address(), no_of_token); //not sure where to get the wallet address and contract address
            if result {
                let transaction = OfframpTransaction { token, no_of_token, sender_address };
                self.contract_balance.write(token, self.contract_balance.read(token) + no_of_token);
            }
            // self.balance.write(self.balance.read() + quantity);
            self.emit(
                    OfframpTransaction {
                        token: ContractAddress,
                        no_of_token: u256,
                        sender_address: ContractAdress
                    }
                );
        }
//ONramp
 #[external(v0)]
    impl Onramp of super::IOfframp<ContractState> {
        fn transactOnramp(
            ref self: ContractState,
            receipient_address: ContractAdress,
            token: ContractAddress,
            no_of_token: u256,
        ) {
            //transfers tokens
            //updates contract_balance

            let token_: IERC20Dispatcher = IERC20Dispatcher { contract_address: token };
            let result = token_
                .transfer(  receipient_address, get_contract_address(), no_of_token);//check here
                // .transfer(get_caller_address(), get_contract_address(), no_of_token); //

            if result {
                let transaction = OfframpTransaction { token, no_of_token, sender_address };
                self.contract_balance.write(token, self.contract_balance.read(token) + no_of_token);
            }
            // self.balance.write(self.balance.read() + quantity);
            self.emit(
                    OnrampTransaction {
                        token: ContractAddress,
                        no_of_token: u256,
                        receipient_address: ContractAdress
                    }
                );
        }

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
    }
}

// shall do this from frontend insteas so as to get net_amount

//let mut markteplace_fee= 0.01 *gross_amount;
//    let deduction=500;
//   let total_deduction= markteplace_fee+deduction;
//  let net_amount= gross_amount-total_deduction;


