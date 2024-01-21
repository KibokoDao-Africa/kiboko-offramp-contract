#[starknet::contract]
mod Offramp {
    use core::starknet::event::EventEmitter;
    use core::traits::Into;
    use core::option::OptionTrait;
    use core::traits::TryInto;
    use core::array::ArrayTrait;
    use starknet::{get_caller_address, get_block_timestamp, get_contract_address, ContractAddress};
    use offramp::erc20::{IERC20Dispatcher, IERC20DispatcherTrait};

    use offramp::interfaces::{IOnramp, IOfframp};
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
        OnrampTransaction: OnrampTransaction
    }
    #[derive(Drop, starknet::Event)]
    struct OfframpTransaction {
        token: ContractAddress,
        no_of_token: u256,
        sender_address: ContractAddress
    }

    #[derive(Drop, starknet::Event)]
    struct OnrampTransaction {
        token: ContractAddress,
        no_of_token: u256,
        receipient_address: ContractAddress
    }


    #[external(v0)]
    impl Offramp of IOfframp<ContractState> {
        fn transactOfframp(
            ref self: ContractState,
            token: ContractAddress,
            no_of_token: u256,
            sender_address: ContractAddress
        ) {
            //transfers tokens
            //updates contract_balance

            let token_: IERC20Dispatcher = IERC20Dispatcher { contract_address: token };
            let result = token_.transferFrom(get_contract_address(), sender_address, no_of_token);
            // .transferFrom(get_caller_address(), get_contract_address(), no_of_token); //not sure where to get the wallet address and contract address
            if result {
                let transaction = OfframpTransaction { token, no_of_token, sender_address };
                self.contract_balance.write(token, self.contract_balance.read(token) + no_of_token);
            }
            // self.balance.write(self.balance.read() + quantity);
            self
                .emit(
                    OfframpTransaction {
                        token: token, no_of_token: no_of_token, sender_address: sender_address
                    }
                );
        }
    }

    //ONramp
    #[external(v0)]
    impl Onramp of IOnramp<ContractState> {
        fn transactOnramp(
            ref self: ContractState,
            token: ContractAddress,
            no_of_token: u256,
            receipient_address: ContractAddress,
        ) {
            //transfers tokens
            //updates contract_balance

            let token_: IERC20Dispatcher = IERC20Dispatcher { contract_address: token };
            let result = token_
                .transfer(receipient_address, no_of_token); //check here removed getcontract
            // .transfer(get_caller_address(), get_contract_address(), no_of_token); //

            if result {
                let transaction = OnrampTransaction { token, no_of_token, receipient_address };
                self.contract_balance.write(token, self.contract_balance.read(token) + no_of_token);
            }
            // self.balance.write(self.balance.read() + quantity);
            self.emit(OnrampTransaction { token, no_of_token, receipient_address });
        }
    }

  #[external(v0)]
    fn get_balance(self: @ContractState ,token:ContractAddress)  -> u256 {
        self.contract_balance.read(token)
    }

  #[external(v0)]
    fn withdraw(ref self: ContractState, token: Token, no_of_token: Quantity) {
        assert(self.owner.read() == get_caller_address(), 'Only Owner can Call');
        let token_: IERC20Dispatcher = IERC20Dispatcher { contract_address: token };
        let result = token_.transfer(get_caller_address(), no_of_token);
        self.contract_balance.write(token, self.contract_balance.read(token) - no_of_token);
    }
    
  #[external(v0)]
    fn donate(ref self: ContractState, token: Token, no_of_token: Quantity) {
        let token_: IERC20Dispatcher = IERC20Dispatcher { contract_address: token };
        let result = token_
            .transferFrom(
                get_caller_address(), get_contract_address(), no_of_token
            ); //shida kwa get_caller_address()
        self.contract_balance.write(token, self.contract_balance.read(token) + no_of_token);
    }
}



