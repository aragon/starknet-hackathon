%lang starknet


struct Poll:
	member result
    member allowed_voters : felt*
end 

# Store information on the vote requirments 
@storage_var
func polls(poll_id: felt) -> (poll: Poll):
end

# Store information on the results of the votes
@storage_var
func poll_results(poll_id: felt) -> (result: felt):
end


# Increases the balance by the given amount.
@external
func create_poll{
    syscall_ptr : felt*,
    pedersen_ptr : HashBuiltin*,
    range_check_ptr,
}(votes : felt*, duration: ???):
    let (res) = balance.read()
    balance.write(res + amount)
    return ()
end

@external
func recieved_vote() {

}

@external
func finilise_votes() {

}