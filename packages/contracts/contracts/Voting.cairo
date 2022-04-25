%lang starknet

from starkware.cairo.common.math import assert_not_zero

# Structure for storing poll information
struct Poll:
	member result : felt # Vote result: 1 = PASSED, -1 = FAILED, 0 - NOT DEFINED
	member termination_time : felt # When the vote should be shut down
    member eligible_voters : felt* # list of people who are allowed to vote
end 

# Map between poll id and the data of the poll
@storage_var
func polls_result_storage(poll_id: felt) -> (result: felt):
end

@storage_var
func polls_termination_time_storage(poll_id: felt) -> (termination_time: felt):
end

@storage_var
func polls_eligible_voters_storage(poll_id: felt) -> (eligible_voters: felt):
end


# Create a poll with parameters
@external
func create_poll():
	return ()
end

# Receive a vote and store it in memory
@external
func recieved_vote():
	return ()
end

# Check that the duration of the vote has passed and calculate the result
@external
func finilise_votes():
	return ()
end

# Retreive result of the vote 
@view 
func view_result{syscall_ptr : felt*
}(vote_id : felt) -> (result : felt):
	return (1)
end


