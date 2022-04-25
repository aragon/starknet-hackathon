%lang starknet

%builtins pedersen range_check

from starkware.cairo.common.math import assert_not_zero
from starkware.cairo.common.cairo_builtins import HashBuiltin
from starkware.starknet.common.syscalls import get_block_timestamp


# Structure for storing poll information
struct Poll:
    member result : felt  # Vote result: 1 = PASSED, -1 = FAILED, 0 - NOT DEFINED
    member termination_time : felt  # When the vote should be shut down
    member eligible_voters : felt*  # list of people who are allowed to vote
end

# Map between poll id and the data of the poll

@storage_var
func polls_counter() -> (count : felt):
end

@storage_var
func polls_result_storage(poll_id : felt) -> (result : felt):
end

@storage_var
func polls_termination_time_storage(poll_id : felt) -> (termination_time : felt):
end

@storage_var
func polls_eligible_voters_storage(poll_id : felt) -> (eligible_voters : felt):
end

# Create a poll with parameters
@external
func create_poll{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}(
        duration : felt) -> (poll_id : felt):
    alloc_locals
    let (current_poll_count) = polls_counter.read()
    local new_poll_count = current_poll_count + 1
    polls_counter.write(new_poll_count)

    let (block_timestamp) = get_block_timestamp()
    polls_termination_time_storage.write(new_poll_count, block_timestamp + duration)

    return (new_poll_count)
end

# Receive a vote and store it in memory
@external
func recieved_vote():
    return ()
end

# Check that the duration of the vote has passed and calculate the result
@external
func finalize_votes():
    return ()
end

# Retreive result of the vote 
@view 
func view_result{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr
}(poll_id : felt) -> (result : felt):

	# If poll does not exist, through an error 
	check_if_poll_exists(poll_id)

	let (result : felt) = polls_result_storage.read(poll_id)

	return (result)
end

# Retreive the termination time
@view
func termination_time{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}(
        poll_id : felt) -> (termination_timestamp : felt):
    let (termination_timestamp) = polls_termination_time_storage.read(poll_id)
    return (termination_timestamp)
end

# Check if poll with provided id exists
func check_if_poll_exists{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}(poll_id : felt):

	let (eligible_voters) = polls_eligible_voters_storage.read(poll_id)

	with_attr error_message("The poll with id does not exist"):
        assert_not_zero(eligible_voters)
    end

    return ()
end


