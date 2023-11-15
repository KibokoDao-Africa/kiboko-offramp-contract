//1.initialize contract.
//2.Storafe struct .
//3. Add methods to a trait.
//4.Implement events.

#[starknet::interface]
trait IOfframp<TContractState> {
    // fn increase_balance(ref self: TContractState, amount: felt252);
    // fn get_balance(self: @TContractState) -> felt252;

    fn trasfer(ref self: TContractState,ref self:quantity)->felt252;
    fn offramp(ref self: phone_number,ref self:amount_inKes)->felt252;
}

#[starknet::contract]
mod Offramp {
    #[storage]
    struct Storage {
        balance: felt252,
        quantity:felt252,
        phone_number:felt252,
        amount_inKes:felt252

    }

    #[external(v0)]
    impl Offramp of super::IOPfframp<ContractState> {
        fn trasfer(ref self: ContractState, quantity: felt252) {
            assert(amount != 0, 'Amount cannot be 0');
            self.balance.write(self.balance.read() + amount);

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
            //call chainlink to call the send money api
            //emit event

        }
    }
}
